-- PostgREST sxema keshi: .from().insert() o‘rniga RPC (SECURITY DEFINER) — INSERT to‘g‘ridan-to‘g‘ri PG da.

-- Jadval (birinchi migratsiya o‘tkazilmagan bo‘lsa)
create table if not exists public.telegram_login_tokens (
  id uuid primary key default gen_random_uuid(),
  token text unique not null,
  telegram_id bigint,
  status text not null default 'pending',
  used boolean not null default false,
  expires_at timestamptz not null,
  created_at timestamptz not null default now()
);

create table if not exists public.telegram_users (
  id uuid primary key default gen_random_uuid(),
  telegram_id bigint not null unique,
  username text,
  first_name text,
  last_name text,
  photo_url text,
  role text not null default 'job_seeker',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Eski jadvalda yetishmayotgan ustunlar
alter table public.telegram_login_tokens add column if not exists status text default 'pending';
update public.telegram_login_tokens set status = coalesce(status, 'pending');
alter table public.telegram_login_tokens alter column status set default 'pending';
alter table public.telegram_login_tokens alter column status set not null;

alter table public.telegram_login_tokens add column if not exists used boolean default false;
update public.telegram_login_tokens set used = coalesce(used, false);
alter table public.telegram_login_tokens alter column used set default false;
alter table public.telegram_login_tokens alter column used set not null;

alter table public.telegram_login_tokens add column if not exists expires_at timestamptz;
update public.telegram_login_tokens set expires_at = now() + interval '5 minutes' where expires_at is null;
alter table public.telegram_login_tokens alter column expires_at set not null;

alter table public.telegram_login_tokens add column if not exists created_at timestamptz default now();
update public.telegram_login_tokens set created_at = coalesce(created_at, now());
alter table public.telegram_login_tokens alter column created_at set default now();
alter table public.telegram_login_tokens alter column created_at set not null;

alter table public.telegram_login_tokens add column if not exists telegram_id bigint;

do $$
begin
  alter table public.telegram_login_tokens
    add constraint telegram_login_tokens_status_check
    check (status in ('pending', 'confirmed', 'expired'));
exception when duplicate_object then null;
end $$;

alter table public.telegram_login_tokens enable row level security;
alter table public.telegram_users enable row level security;

-- RPC
create or replace function public.workora_create_telegram_login_token()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_token text;
  v_expires timestamptz := now() + interval '5 minutes';
begin
  v_token := replace(gen_random_uuid()::text || gen_random_uuid()::text, '-', '');
  insert into public.telegram_login_tokens (token, status, used, expires_at)
  values (v_token, 'pending', false, v_expires);
  return jsonb_build_object('token', v_token, 'expires_at', v_expires);
end;
$$;

create or replace function public.workora_check_telegram_login_token(p_token text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  r record;
  u jsonb;
begin
  if p_token is null or length(trim(p_token)) = 0 then
    return jsonb_build_object('status', 'invalid');
  end if;

  select id, token, telegram_id, status, used, expires_at
  into r
  from public.telegram_login_tokens
  where token = trim(p_token)
  limit 1;

  if not found then
    return jsonb_build_object('status', 'invalid');
  end if;

  if r.status = 'confirmed' and r.used and r.telegram_id is not null then
    select to_jsonb(t) into u
    from public.telegram_users t
    where t.telegram_id = r.telegram_id
    limit 1;
    if u is null then
      return jsonb_build_object('status', 'invalid');
    end if;
    return jsonb_build_object('status', 'confirmed', 'telegram_user', u);
  end if;

  if r.used or r.status = 'confirmed' then
    return jsonb_build_object('status', 'invalid');
  end if;

  if r.status = 'expired' or r.expires_at <= now() then
    if r.status = 'pending' then
      update public.telegram_login_tokens set status = 'expired' where id = r.id;
    end if;
    return jsonb_build_object('status', 'expired');
  end if;

  return jsonb_build_object('status', 'pending');
end;
$$;

create or replace function public.workora_telegram_finish_login(
  p_token text,
  p_telegram_id bigint,
  p_username text,
  p_first_name text,
  p_last_name text,
  p_photo_url text
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  r record;
  v_role text;
  n int;
begin
  if p_token is null or p_telegram_id is null then
    return jsonb_build_object('ok', false, 'reason', 'bad_input');
  end if;

  select id, used, status, expires_at
  into r
  from public.telegram_login_tokens
  where token = trim(p_token)
  for update;

  if not found then
    return jsonb_build_object('ok', false, 'reason', 'not_found');
  end if;

  if r.used or r.status <> 'pending' or r.expires_at <= now() then
    return jsonb_build_object('ok', false, 'reason', 'bad_state');
  end if;

  select tu.role into v_role
  from public.telegram_users tu
  where tu.telegram_id = p_telegram_id;

  if not found then
    v_role := 'job_seeker';
  end if;

  insert into public.telegram_users (
    telegram_id, username, first_name, last_name, photo_url, role, updated_at
  )
  values (
    p_telegram_id,
    nullif(p_username, ''),
    nullif(p_first_name, ''),
    nullif(p_last_name, ''),
    nullif(p_photo_url, ''),
    v_role,
    now()
  )
  on conflict (telegram_id) do update set
    username = coalesce(excluded.username, telegram_users.username),
    first_name = coalesce(excluded.first_name, telegram_users.first_name),
    last_name = coalesce(excluded.last_name, telegram_users.last_name),
    photo_url = coalesce(excluded.photo_url, telegram_users.photo_url),
    updated_at = excluded.updated_at;

  update public.telegram_login_tokens
  set
    status = 'confirmed',
    telegram_id = p_telegram_id,
    used = true
  where id = r.id
    and used = false
    and status = 'pending'
    and expires_at > now();

  get diagnostics n = row_count;
  if n = 0 then
    return jsonb_build_object('ok', false, 'reason', 'race');
  end if;

  return jsonb_build_object('ok', true);
end;
$$;

revoke all on function public.workora_create_telegram_login_token() from public;
revoke all on function public.workora_check_telegram_login_token(text) from public;
revoke all on function public.workora_telegram_finish_login(text, bigint, text, text, text, text) from public;

grant execute on function public.workora_create_telegram_login_token() to service_role;
grant execute on function public.workora_check_telegram_login_token(text) to service_role;
grant execute on function public.workora_telegram_finish_login(text, bigint, text, text, text, text) to service_role;

notify pgrst, 'reload schema';
