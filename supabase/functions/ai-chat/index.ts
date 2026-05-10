// @ts-ignore Deno Edge Runtime resolves remote imports at deploy/runtime.
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
// @ts-ignore Deno Edge Runtime resolves remote imports at deploy/runtime.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"

declare const Deno: {
  env: { get(key: string): string | undefined }
}

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })

  try {
    const { message } = await req.json()
    const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY')
    
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // 1. Foydalanuvchi savolini vektorga aylantirish
    const embedRes = await fetch('https://api.openai.com/v1/embeddings', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: 'text-embedding-3-small',
        input: message,
      }),
    })
    const embedData = await embedRes.json()
    const embedding = embedData.data[0].embedding

    // 2. Bazadan eng yaqin vakansiyalarni qidirish
    const { data: matchedVacancies, error: rpcError } = await supabase.rpc('match_vacancies', {
      query_embedding: embedding,
      match_threshold: 0.2, // 20% o'xshashlik bo'lsa ham topadi
      match_count: 3,
    })

    if (rpcError) throw rpcError

    // 3. Topilgan ma'lumotlarni matn holatiga keltirish
    const context = matchedVacancies && matchedVacancies.length > 0 
      ? matchedVacancies.map((v: any) => 
          `Kompaniya: ${v.company}, Lavozim: ${v.title}, Joy: ${v.location}, Maosh: ${v.salary}, Tajriba: ${v.experience}, Tavsif: ${v.description}`
        ).join('\n---\n')
      : "Hozircha bazada mos vakansiyalar topilmadi."

    // 4. OpenAI-ga kontekstni berib javob so'rash
    const chatRes = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        messages: [
          { 
            role: 'system', 
            content: `Siz Workora yordamchisisiz. Faqat quyidagi berilgan vakansiyalar asosida javob bering. 
            Agar mos ish bo'lsa, foydalanuvchiga kompaniya nomi, maoshi va talablarini ayting. 
            Agar ma'lumot topilmasa, bazada hozircha bunday ish yo'qligini ayting.
            
            KONTEKST:
            ${context}` 
          },
          { role: 'user', content: message }
        ],
      }),
    })

    const chatData = await chatRes.json()
    const reply = chatData.choices[0].message.content

    return new Response(JSON.stringify({ reply }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500, headers: corsHeaders
    })
  }
})