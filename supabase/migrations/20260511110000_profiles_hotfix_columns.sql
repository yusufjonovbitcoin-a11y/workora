-- Avvalgi migratsiya yarmicha ishlab qolgan bo‘lsa yoki `profiles` eski shablonda bo‘lsa —
-- SQL Editor da bu faylni alohida ishga tushirish mumkin (xavfsiz takrorlash mumkin).

alter table public.profiles add column if not exists updated_at timestamptz;

update public.profiles set updated_at = now() where updated_at is null;

alter table public.profiles alter column updated_at set default now();

alter table public.profiles alter column updated_at set not null;

create index if not exists profiles_updated_at_idx on public.profiles (updated_at desc);
