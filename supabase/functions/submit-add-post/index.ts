import { createClient } from "npm:@supabase/supabase-js@2.49.1";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Max-Age": "86400",
};

type Body = {
  type?: "job_seeker" | "employer";
  telegram_id?: number;
  payload?: Record<string, unknown>;
};

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: cors });
  }
  if (req.method !== "POST") {
    return json({ error: "Method not allowed" }, 405);
  }

  const url = Deno.env.get("SUPABASE_URL");
  const key = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!url || !key) return json({ error: "Server misconfigured" }, 500);

  let body: Body;
  try {
    body = await req.json();
  } catch {
    return json({ error: "Invalid JSON" }, 400);
  }

  if (body.telegram_id == null || typeof body.telegram_id !== "number") {
    return json({ error: "telegram_id required" }, 400);
  }
  if (body.type !== "job_seeker" && body.type !== "employer") {
    return json({ error: "type required" }, 400);
  }
  if (!body.payload || typeof body.payload !== "object") {
    return json({ error: "payload required" }, 400);
  }

  const admin = createClient(url, key, {
    auth: { autoRefreshToken: false, persistSession: false },
  });

  const { data: telegramUser, error: userError } = await admin
    .from("telegram_users")
    .select("id")
    .eq("telegram_id", body.telegram_id)
    .maybeSingle();

  if (userError) return json({ error: userError.message }, 500);
  if (!telegramUser) return json({ error: "Telegram foydalanuvchi topilmadi" }, 404);

  const payload = {
    ...body.payload,
    owner_telegram_user_id: telegramUser.id,
    updated_at: new Date().toISOString(),
  };

  const table = body.type === "job_seeker" ? "job_seeker_posts" : "vacancies";
  const { data, error } = await admin
    .from(table)
    .insert(payload)
    .select("id")
    .single();

  if (error) return json({ error: error.message }, 500);
  return json({ ok: true, id: data.id });
});

function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...cors, "Content-Type": "application/json" },
  });
}
