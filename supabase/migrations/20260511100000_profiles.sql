-- Profil — auth.users bilan bog‘langan.
-- Eski `profiles` jadvali bo‘lsa ham ustunlar qo‘shiladi (IF NOT EXISTS).

create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade
);

alter table public.profiles add column if not exists full_name text default '';
alter table public.profiles add column if not exists profession text default '';
alter table public.profiles add column if not exists bio text default '';
alter table public.profiles add column if not exists phone text default '';
alter table public.profiles add column if not exists location text default '';
alter table public.profiles add column if not exists avatar_url text;
alter table public.profiles add column if not exists skills jsonb default '[]'::jsonb;
alter table public.profiles add column if not exists languages jsonb default '[]'::jsonb;
alter table public.profiles add column if not exists experiences jsonb default '[]'::jsonb;
alter table public.profiles add column if not exists cv_url text;
alter table public.profiles add column if not exists cv_file_name text default '';

-- updated_at — avvalgi migratsiyada yo‘q bo‘lsa shu yerda paydo bo‘ladi
alter table public.profiles add column if not exists updated_at timestamptz;

update public.profiles set updated_at = now() where updated_at is null;
alter table public.profiles alter column updated_at set default now();
alter table public.profiles alter column updated_at set not null;

update public.profiles set skills = coalesce(skills, '[]'::jsonb);
update public.profiles set languages = coalesce(languages, '[]'::jsonb);
update public.profiles set experiences = coalesce(experiences, '[]'::jsonb);

alter table public.profiles alter column skills set default '[]'::jsonb;
alter table public.profiles alter column languages set default '[]'::jsonb;
alter table public.profiles alter column experiences set default '[]'::jsonb;

alter table public.profiles alter column skills set not null;
alter table public.profiles alter column languages set not null;
alter table public.profiles alter column experiences set not null;

create index if not exists profiles_updated_at_idx on public.profiles (updated_at desc);

alter table public.profiles enable row level security;

drop policy if exists "profiles_select_own" on public.profiles;
drop policy if exists "profiles_insert_own" on public.profiles;
drop policy if exists "profiles_update_own" on public.profiles;

create policy "profiles_select_own"
  on public.profiles for select
  using (auth.uid() = id);

create policy "profiles_insert_own"
  on public.profiles for insert
  with check (auth.uid() = id);

create policy "profiles_update_own"
  on public.profiles for update
  using (auth.uid() = id);

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id)
  values (new.id)
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
