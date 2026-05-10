import { createClient } from "npm:@supabase/supabase-js@2.49.1";



const cors = {

  "Access-Control-Allow-Origin": "*",

  "Access-Control-Allow-Headers":

    "authorization, x-client-info, apikey, content-type",

};



Deno.serve(async (req: Request) => {

  if (req.method === "OPTIONS") {

    return new Response("ok", { headers: cors });

  }

  if (req.method !== "POST") {

    return new Response(JSON.stringify({ error: "Method not allowed" }), {

      status: 405,

      headers: { ...cors, "Content-Type": "application/json" },

    });

  }



  const supabaseUrl = Deno.env.get("SUPABASE_URL");

  const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

  const botUsername = Deno.env.get("TELEGRAM_BOT_USERNAME");



  if (!supabaseUrl || !serviceRoleKey || !botUsername) {

    return new Response(

      JSON.stringify({ error: "Server misconfigured" }),

      { status: 500, headers: { ...cors, "Content-Type": "application/json" } },

    );

  }



  const admin = createClient(supabaseUrl, serviceRoleKey, {

    auth: { autoRefreshToken: false, persistSession: false },

  });



  const { data, error } = await admin.rpc("workora_create_telegram_login_token");



  if (error) {

    return new Response(JSON.stringify({ error: error.message }), {

      status: 500,

      headers: { ...cors, "Content-Type": "application/json" },

    });

  }



  const row = data as { token?: string } | null;

  const token = row?.token;

  if (!token) {

    return new Response(JSON.stringify({ error: "RPC returned no token" }), {

      status: 500,

      headers: { ...cors, "Content-Type": "application/json" },

    });

  }



  const cleanUser = botUsername.replace(/^@/, "");

  const botUrl = `https://t.me/${cleanUser}?start=${token}`;



  return new Response(JSON.stringify({ token, bot_url: botUrl }), {

    headers: { ...cors, "Content-Type": "application/json" },

  });

});


