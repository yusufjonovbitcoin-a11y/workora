import { createClient } from "npm:@supabase/supabase-js@2.49.1";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

type TelegramUserRow = {
  id: string;
  telegram_id: number;
  username?: string | null;
  first_name?: string | null;
  last_name?: string | null;
  photo_url?: string | null;
  role?: string | null;
  auth_user_id?: string | null;
};

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: cors });
  }

  if (req.method !== "POST") {
    return json({ error: "Method not allowed" }, 405);
  }

  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

  if (!supabaseUrl || !serviceRoleKey) {
    return json({ error: "Server misconfigured" }, 500);
  }

  let body: { token?: string };
  try {
    body = await req.json();
  } catch {
    return json({ status: "invalid" }, 400);
  }

  const token = body.token?.trim();
  if (!token) return json({ status: "invalid" }, 400);

  const admin = createClient(supabaseUrl, serviceRoleKey, {
    auth: { autoRefreshToken: false, persistSession: false },
  });

  const { data, error } = await admin.rpc("workora_check_telegram_login_token", {
    p_token: token,
  });

  if (error) return json({ error: error.message }, 500);
  const payload = data ?? { status: "invalid" };

  if (payload.status !== "confirmed" || !payload.telegram_user) {
    return json(payload);
  }

  const telegramUser = payload.telegram_user as TelegramUserRow;
  const exchange = await ensureAuthExchange(admin, telegramUser);
  if ("error" in exchange) return json({ error: exchange.error }, 500);

  return json({
    ...payload,
    telegram_user: {
      ...telegramUser,
      auth_user_id: exchange.authUserId,
    },
    auth_token_hash: exchange.tokenHash,
    auth_email: exchange.email,
  });
});

async function ensureAuthExchange(
  admin: ReturnType<typeof createClient>,
  telegramUser: TelegramUserRow,
): Promise<
  | { authUserId: string; email: string; tokenHash: string }
  | { error: string }
> {
  const email = `telegram_${telegramUser.telegram_id}@telegram.workora.local`;
  const metadata = {
    provider: "telegram",
    telegram_id: telegramUser.telegram_id,
    telegram_username: telegramUser.username ?? null,
  };

  let authUserId = telegramUser.auth_user_id ?? null;

  if (authUserId) {
    const { data, error } = await admin.auth.admin.getUserById(authUserId);
    if (error || !data.user) authUserId = null;
  }

  if (!authUserId) {
    const { data, error } = await admin.auth.admin.createUser({
      email,
      email_confirm: true,
      user_metadata: metadata,
    });

    if (error) {
      const existing = await findUserByEmail(admin, email);
      if ("error" in existing) return existing;
      authUserId = existing.authUserId;
    } else {
      authUserId = data.user?.id ?? null;
    }
  }

  if (!authUserId) return { error: "Auth user yaratib bo‘lmadi" };

  const fullName = [telegramUser.first_name, telegramUser.last_name]
    .filter(Boolean)
    .join(" ")
    .trim();

  const { error: telegramUpdateError } = await admin
    .from("telegram_users")
    .update({ auth_user_id: authUserId })
    .eq("id", telegramUser.id);
  if (telegramUpdateError) return { error: telegramUpdateError.message };

  const { error: profileError } = await admin.from("profiles").upsert({
    id: authUserId,
    telegram_user_id: telegramUser.id,
    full_name: fullName,
    avatar_url: telegramUser.photo_url ?? null,
    role: telegramUser.role ?? "job_seeker",
    updated_at: new Date().toISOString(),
  });
  if (profileError) return { error: profileError.message };

  const { data: link, error: linkError } = await admin.auth.admin.generateLink({
    type: "magiclink",
    email,
  });
  if (linkError) return { error: linkError.message };

  const tokenHash = link.properties?.hashed_token;
  if (!tokenHash) return { error: "Auth token hash yaratilmadi" };

  return { authUserId, email, tokenHash };
}

async function findUserByEmail(
  admin: ReturnType<typeof createClient>,
  email: string,
): Promise<{ authUserId: string } | { error: string }> {
  for (let page = 1; page <= 10; page += 1) {
    const { data, error } = await admin.auth.admin.listUsers({
      page,
      perPage: 1000,
    });
    if (error) return { error: error.message };

    const user = data.users.find(
      (candidate) => candidate.email?.toLowerCase() === email.toLowerCase(),
    );
    if (user) return { authUserId: user.id };
    if (data.users.length < 1000) break;
  }

  return { error: "Mavjud Auth user topilmadi" };
}

function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...cors, "Content-Type": "application/json" },
  });
}
