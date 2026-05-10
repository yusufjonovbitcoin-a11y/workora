-- Hotfix: ensure Telegram profile columns exist and refresh PostgREST schema cache.
-- The Edge Functions update `telegram_users` through PostgREST, so new columns
-- must be visible in its schema cache.

alter table public.telegram_users add column if not exists full_name text default '';
alter table public.telegram_users add column if not exists profession text default '';
alter table public.telegram_users add column if not exists bio text default '';
alter table public.telegram_users add column if not exists phone text default '';
alter table public.telegram_users add column if not exists location text default '';
alter table public.telegram_users add column if not exists skills jsonb default '[]'::jsonb;
alter table public.telegram_users add column if not exists languages jsonb default '[]'::jsonb;
alter table public.telegram_users add column if not exists experiences jsonb default '[]'::jsonb;
alter table public.telegram_users add column if not exists cv_file_name text default '';

update public.telegram_users set skills = coalesce(skills, '[]'::jsonb);
update public.telegram_users set languages = coalesce(languages, '[]'::jsonb);
update public.telegram_users set experiences = coalesce(experiences, '[]'::jsonb);

alter table public.telegram_users alter column skills set default '[]'::jsonb;
alter table public.telegram_users alter column languages set default '[]'::jsonb;
alter table public.telegram_users alter column experiences set default '[]'::jsonb;

alter table public.telegram_users alter column skills set not null;
alter table public.telegram_users alter column languages set not null;
alter table public.telegram_users alter column experiences set not null;

notify pgrst, 'reload schema';
