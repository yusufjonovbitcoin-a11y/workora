alter table public.telegram_users
  add column if not exists auth_user_id uuid references auth.users (id) on delete set null;

alter table public.profiles
  add column if not exists telegram_user_id uuid references public.telegram_users (id) on delete set null,
  add column if not exists role text not null default 'job_seeker';

create unique index if not exists telegram_users_auth_user_id_key
  on public.telegram_users (auth_user_id)
  where auth_user_id is not null;

create unique index if not exists profiles_telegram_user_id_key
  on public.profiles (telegram_user_id)
  where telegram_user_id is not null;

do $$
begin
  alter table public.profiles
    add constraint profiles_role_check
    check (role in ('job_seeker', 'employer', 'admin', 'super_admin'));
exception when duplicate_object then null;
end $$;

notify pgrst, 'reload schema';
