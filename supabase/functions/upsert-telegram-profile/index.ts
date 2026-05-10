import { createClient } from "npm:@supabase/supabase-js@2.49.1";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Max-Age": "86400",
};

type Body = {
  telegram_id?: number;
  full_name?: string;
  profession?: string;
  bio?: string;
  phone?: string;
  location?: string;
  skills?: unknown;
  languages?: unknown;
  experiences?: unknown;
  cv_file_name?: string;
};

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: cors });
  }
  if (req.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method not allowed" }), {
      status: 405,
      headers: { ...cors, "Content-Type": "application/json" },
    });
  }

  const url = Deno.env.get("SUPABASE_URL");
  const key = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!url || !key) {
    return new Response(JSON.stringify({ error: "Server misconfigured" }), {
      status: 500,
      headers: { ...cors, "Content-Type": "application/json" },
    });
  }

  let body: Body;
  try {
    body = await req.json();
  } catch {
    return new Response(JSON.stringify({ error: "Invalid JSON" }), {
      status: 400,
      headers: { ...cors, "Content-Type": "application/json" },
    });
  }

  const tid = body.telegram_id;
  if (tid == null || typeof tid !== "number") {
    return new Response(JSON.stringify({ error: "telegram_id required" }), {
      status: 400,
      headers: { ...cors, "Content-Type": "application/json" },
    });
  }

  const admin = createClient(url, key, {
    auth: { autoRefreshToken: false, persistSession: false },
  });

  const update = {
    full_name: body.full_name ?? "",
    profession: body.profession ?? "",
    bio: body.bio ?? "",
    phone: body.phone ?? "",
    location: body.location ?? "",
    skills: body.skills ?? [],
    languages: body.languages ?? [],
    experiences: body.experiences ?? [],
    cv_file_name: body.cv_file_name ?? "",
    updated_at: new Date().toISOString(),
  };

  const { data, error } = await admin
    .from("telegram_users")
    .update(update)
    .eq("telegram_id", tid)
    .select("id")
    .maybeSingle();

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...cors, "Content-Type": "application/json" },
    });
  }

  if (!data) {
    return new Response(
      JSON.stringify({ error: "Telegram foydalanuvchi topilmadi" }),
      { status: 404, headers: { ...cors, "Content-Type": "application/json" } },
    );
  }

  return new Response(JSON.stringify({ ok: true }), {
    headers: { ...cors, "Content-Type": "application/json" },
  });
});
