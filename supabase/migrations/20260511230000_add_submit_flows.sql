create extension if not exists pgcrypto with schema extensions;

alter table public.vacancies
  add column if not exists owner_profile_id uuid references auth.users (id) on delete set null,
  add column if not exists owner_telegram_user_id uuid references public.telegram_users (id) on delete set null,
  add column if not exists contact text not null default '',
  add column if not exists experience text not null default '';

create index if not exists vacancies_owner_profile_idx
  on public.vacancies (owner_profile_id);

create index if not exists vacancies_owner_telegram_user_idx
  on public.vacancies (owner_telegram_user_id);

drop policy if exists "vacancies_insert_own" on public.vacancies;
drop policy if exists "vacancies_update_own" on public.vacancies;

create policy "vacancies_insert_own"
  on public.vacancies for insert
  with check (auth.uid() = owner_profile_id);

create policy "vacancies_update_own"
  on public.vacancies for update
  using (auth.uid() = owner_profile_id)
  with check (auth.uid() = owner_profile_id);

grant insert, update on public.vacancies to authenticated;

create table if not exists public.job_seeker_posts (
  id uuid primary key default extensions.gen_random_uuid(),
  owner_profile_id uuid references auth.users (id) on delete set null,
  owner_telegram_user_id uuid references public.telegram_users (id) on delete set null,
  profession text not null,
  job_type text not null default '',
  location text not null default '',
  expected_salary text not null default '',
  experience text not null default '',
  skills text[] not null default '{}'::text[],
  education text not null default '',
  languages text[] not null default '{}'::text[],
  about text not null default '',
  contact text not null default '',
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint job_seeker_posts_owner_check check (
    owner_profile_id is not null or owner_telegram_user_id is not null
  )
);

create index if not exists job_seeker_posts_active_created_idx
  on public.job_seeker_posts (is_active, created_at desc);

create index if not exists job_seeker_posts_owner_profile_idx
  on public.job_seeker_posts (owner_profile_id);

create index if not exists job_seeker_posts_owner_telegram_user_idx
  on public.job_seeker_posts (owner_telegram_user_id);

alter table public.job_seeker_posts enable row level security;

drop policy if exists "job_seeker_posts_read_active" on public.job_seeker_posts;
drop policy if exists "job_seeker_posts_insert_own" on public.job_seeker_posts;
drop policy if exists "job_seeker_posts_update_own" on public.job_seeker_posts;

create policy "job_seeker_posts_read_active"
  on public.job_seeker_posts for select
  using (is_active = true);

create policy "job_seeker_posts_insert_own"
  on public.job_seeker_posts for insert
  with check (auth.uid() = owner_profile_id);

create policy "job_seeker_posts_update_own"
  on public.job_seeker_posts for update
  using (auth.uid() = owner_profile_id)
  with check (auth.uid() = owner_profile_id);

grant select on public.job_seeker_posts to anon, authenticated;
grant insert, update on public.job_seeker_posts to authenticated;
