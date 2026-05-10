-- Eski jadval `CREATE TABLE IF NOT EXISTS` tufayli `status` va boshqa ustunlarsiz qolgan bo‘lishi mumkin.
-- Edge Function `.insert({ status, ... })` PostgREST sxema keshida `status` qidiradi — ustun bo‘lmasa 500.

alter table if exists public.telegram_login_tokens
  add column if not exists status text default 'pending';

update public.telegram_login_tokens
set status = 'pending'
where status is null;

alter table if exists public.telegram_login_tokens
  alter column status set default 'pending';

alter table if exists public.telegram_login_tokens
  alter column status set not null;

alter table if exists public.telegram_login_tokens
  add column if not exists used boolean default false;

update public.telegram_login_tokens
set used = false
where used is null;

alter table if exists public.telegram_login_tokens
  alter column used set default false;

alter table if exists public.telegram_login_tokens
  alter column used set not null;

alter table if exists public.telegram_login_tokens
  add column if not exists expires_at timestamptz;

update public.telegram_login_tokens
set expires_at = now() + interval '5 minutes'
where expires_at is null;

alter table if exists public.telegram_login_tokens
  alter column expires_at set not null;

alter table if exists public.telegram_login_tokens
  add column if not exists created_at timestamptz default now();

update public.telegram_login_tokens
set created_at = now()
where created_at is null;

alter table if exists public.telegram_login_tokens
  alter column created_at set default now();

alter table if exists public.telegram_login_tokens
  alter column created_at set not null;

alter table if exists public.telegram_login_tokens
  add column if not exists telegram_id bigint;

-- CHECK cheklovi (mavjud bo‘lmasa)
do $$
begin
  alter table public.telegram_login_tokens
    add constraint telegram_login_tokens_status_check
    check (status in ('pending', 'confirmed', 'expired'));
exception
  when duplicate_object then null;
end $$;

notify pgrst, 'reload schema';
