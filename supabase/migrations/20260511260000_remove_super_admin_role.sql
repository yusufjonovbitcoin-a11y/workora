-- Super admin rolini ilova va sxemadan olib tashlash (mavjud yozuvlar -> admin)

update public.profiles
set role = 'admin'
where role = 'super_admin';

update public.telegram_users
set role = 'admin'
where role = 'super_admin';

alter table public.profiles drop constraint if exists profiles_role_check;

alter table public.profiles
  add constraint profiles_role_check
  check (role in ('job_seeker', 'employer', 'admin'));

notify pgrst, 'reload schema';
