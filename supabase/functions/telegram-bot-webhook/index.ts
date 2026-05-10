import { createClient } from "npm:@supabase/supabase-js@2.49.1";



const cors = {

  "Access-Control-Allow-Origin": "*",

  "Access-Control-Allow-Headers":

    "authorization, x-client-info, apikey, content-type",

};



type TelegramUser = {

  id: number;

  username?: string;

  first_name?: string;

  last_name?: string;

  photo_url?: string;

};



async function sendTelegramMessage(

  botToken: string,

  chatId: number,

  text: string,

): Promise<void> {

  await fetch(`https://api.telegram.org/bot${botToken}/sendMessage`, {

    method: "POST",

    headers: { "Content-Type": "application/json" },

    body: JSON.stringify({ chat_id: chatId, text }),

  });

}



Deno.serve(async (req: Request) => {

  if (req.method === "OPTIONS") {

    return new Response("ok", { headers: cors });

  }

  if (req.method !== "POST") {

    return new Response("ok", { headers: cors });

  }



  const supabaseUrl = Deno.env.get("SUPABASE_URL");

  const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

  const botToken = Deno.env.get("TELEGRAM_BOT_TOKEN");



  if (!supabaseUrl || !serviceRoleKey || !botToken) {

    return new Response(JSON.stringify({ ok: false }), {

      status: 500,

      headers: { ...cors, "Content-Type": "application/json" },

    });

  }



  const admin = createClient(supabaseUrl, serviceRoleKey, {

    auth: { autoRefreshToken: false, persistSession: false },

  });



  let update: Record<string, unknown>;

  try {

    update = await req.json();

  } catch {

    return new Response(JSON.stringify({ ok: true }), {

      headers: { ...cors, "Content-Type": "application/json" },

    });

  }



  const message = update.message as Record<string, unknown> | undefined;

  if (!message) {

    return new Response(JSON.stringify({ ok: true }), {

      headers: { ...cors, "Content-Type": "application/json" },

    });

  }



  const text = String(message.text ?? "").trim();

  const parts = text.split(/\s+/);

  if (parts[0] !== "/start") {

    return new Response(JSON.stringify({ ok: true }), {

      headers: { ...cors, "Content-Type": "application/json" },

    });

  }



  const loginToken = parts[1];

  const chat = message.chat as { id?: number } | undefined;

  const chatId = chat?.id;

  const from = message.from as TelegramUser | undefined;



  if (!loginToken || !chatId || !from?.id) {

    if (chatId) {

      await sendTelegramMessage(

        botToken,

        chatId,

        "Workora: noto‘g‘ri havola. Ilovadan qayta urinib ko‘ring.",

      );

    }

    return new Response(JSON.stringify({ ok: true }), {

      headers: { ...cors, "Content-Type": "application/json" },

    });

  }



  const photoUrl =

    typeof from.photo_url === "string" && from.photo_url.length > 0

      ? from.photo_url

      : "";



  const { data, error } = await admin.rpc("workora_telegram_finish_login", {

    p_token: loginToken,

    p_telegram_id: from.id,

    p_username: from.username ?? "",

    p_first_name: from.first_name ?? "",

    p_last_name: from.last_name ?? "",

    p_photo_url: photoUrl,

  });



  if (error) {

    await sendTelegramMessage(

      botToken,

      chatId,

      "Workora: server xatosi. Keyinroq urinib ko‘ring.",

    );

    return new Response(JSON.stringify({ ok: true }), {

      headers: { ...cors, "Content-Type": "application/json" },

    });

  }



  const res = data as {
    ok?: boolean;
    reason?: string;
    returning_user?: boolean;
  } | null;

  if (res?.ok === true) {
    const welcomeBack = res.returning_user === true;
    const okText = welcomeBack
      ? "Sizni yana qaytib ko‘rishdan mamnunmiz!\n\nIlovaga qayting!"
      : "Workora ro‘yxatdan o‘tish muvaffaqiyatli ✅\n\nIlovaga qayting!";

    await sendTelegramMessage(botToken, chatId, okText);

    return new Response(JSON.stringify({ ok: true }), {

      headers: { ...cors, "Content-Type": "application/json" },

    });

  }



  const reason = res?.reason ?? "bad_state";

  const msg =

    reason === "not_found"

      ? "Workora: kod topilmadi. Ilovadan yangi kod oling."

      : reason === "bad_state" || reason === "race"

      ? "Workora: kod eskirgan yoki allaqachon ishlatilgan. Ilovadan yangi kod oling."

      : "Workora: xatolik. Qayta urinib ko‘ring.";



  await sendTelegramMessage(botToken, chatId, msg);



  return new Response(JSON.stringify({ ok: true }), {

    headers: { ...cors, "Content-Type": "application/json" },

  });

});


