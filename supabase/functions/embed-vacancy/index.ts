import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"

serve(async (req) => {
  try {
    const { vacancyId } = await req.json()
    console.log(`Processing vacancy: ${vacancyId}`)

    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '' // SERVICE ROLE bo'lishi shart!
    )

    // 1. Ma'lumotni olish
    const { data: vacancy, error: fetchError } = await supabase
      .from('vacancies')
      .select('title, company, location, salary, description')
      .eq('id', vacancyId)
      .single()

    if (fetchError || !vacancy) {
      console.error('Fetch error:', fetchError)
      return new Response('Vacancy not found', { status: 404 })
    }

    const inputText = `${vacancy.title} ${vacancy.company} ${vacancy.location} ${vacancy.description}`

    // 2. OpenAI dan embedding olish
    const openAiRes = await fetch('https://api.openai.com/v1/embeddings', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${Deno.env.get('OPENAI_API_KEY')}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: 'text-embedding-3-small',
        input: inputText,
      }),
    })

    const embeddingData = await openAiRes.json()
    if (!embeddingData.data) {
      console.error('OpenAI Error:', embeddingData)
      return new Response('OpenAI Error', { status: 500 })
    }

    const embedding = embeddingData.data[0].embedding

    // 3. Bazaga saqlash
    const { error: updateError } = await supabase
      .from('vacancies')
      .update({ embedding: embedding }) // Shuni tekshiring!
      .eq('id', vacancyId)

    if (updateError) {
      console.error('Update error:', updateError)
      return new Response('Database update failed', { status: 500 })
    }

    console.log('Successfully updated embedding!')
    return new Response(JSON.stringify({ success: true }), { status: 200 })

  } catch (err) {
    return new Response(err.message, { status: 500 })
  }
})
