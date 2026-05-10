-- Telegram deep-link login: tokens + user profiles (Edge Functions use service role only)

create table if not exists public.telegram_login_tokens (
  id uuid primary key default gen_random_uuid(),
  token text unique not null,
  telegram_id bigint,
  status text not null default 'pending',
  used boolean not null default false,
  expires_at timestamptz not null,
  created_at timestamptz not null default now(),
  constraint telegram_login_tokens_status_check check (
    status in ('pending', 'confirmed', 'expired')
  )
);

create index if not exists telegram_login_tokens_token_idx
  on public.telegram_login_tokens (token);

create index if not exists telegram_login_tokens_expires_at_idx
  on public.telegram_login_tokens (expires_at);

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

create or replace function public.set_telegram_users_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists telegram_users_set_updated_at on public.telegram_users;
create trigger telegram_users_set_updated_at
  before update on public.telegram_users
  for each row
  execute function public.set_telegram_users_updated_at();

alter table public.telegram_login_tokens enable row level security;
alter table public.telegram_users enable row level security;

-- No policies: anon/authenticated cannot read/write; service role bypasses RLS.

comment on table public.telegram_login_tokens is 'Short-lived tokens for Telegram /start deep-link login';
comment on table public.telegram_users is 'Telegram-linked Workora profiles (managed by Edge Functions)';
