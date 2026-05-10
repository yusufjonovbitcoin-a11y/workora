create extension if not exists pgcrypto with schema extensions;

create table if not exists public.vacancies (
  id uuid primary key default extensions.gen_random_uuid(),
  title text not null,
  company text not null,
  verified boolean not null default false,
  logo text not null default '',
  match_score integer not null default 90 check (match_score between 0 and 100),
  location text not null default '',
  salary text not null default '',
  category text not null default 'General',
  job_type text not null default '',
  contract_type text not null default '',
  description text not null default '',
  start_date date,
  employees_needed integer,
  language_requirement text not null default '',
  housing text not null default '',
  requirements text[] not null default '{}'::text[],
  benefits text[] not null default '{}'::text[],
  company_description text not null default '',
  company_location text not null default '',
  company_employees text not null default '',
  company_active_vacancies integer not null default 0,
  reviews jsonb not null default '[]'::jsonb,
  is_active boolean not null default true,
  featured boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists vacancies_active_featured_idx
  on public.vacancies (is_active, featured desc, created_at desc);

create index if not exists vacancies_category_idx
  on public.vacancies (category);

alter table public.vacancies enable row level security;

drop policy if exists "vacancies_read_active" on public.vacancies;

create policy "vacancies_read_active"
  on public.vacancies for select
  using (is_active = true);

grant select on public.vacancies to anon, authenticated;

insert into public.vacancies (
  id,
  title,
  company,
  verified,
  logo,
  match_score,
  location,
  salary,
  category,
  job_type,
  contract_type,
  description,
  start_date,
  employees_needed,
  language_requirement,
  housing,
  requirements,
  benefits,
  company_description,
  company_location,
  company_employees,
  company_active_vacancies,
  reviews,
  featured
) values
(
  '11111111-1111-4111-8111-111111111111',
  'Factory Worker',
  'Samsung Korea',
  true,
  'SAMSUNG',
  92,
  'Koreya, Seul',
  '$2,200 - $2,800',
  'Factory',
  'To''liq ish vaqti',
  'Shartnoma asosida',
  'Samsung Korea zavodida ishlab chiqarish liniyasida ishlash uchun mas''uliyatli va jismonan sog''lom nomzodlar qabul qilinadi. Ish jarayonida mahsulotlarni yig''ish, qadoqlash va sifat nazoratida qatnashish vazifalari mavjud.',
  '2026-07-15',
  20,
  'Koreyscha (boshlang''ich)',
  'Kompaniya ta''minlaydi',
  array[
    '18 - 45 yosh oralig''ida',
    'Jismoniy jihatdan sog''lom',
    'Pasport va hujjatlari to''liq bo''lishi',
    'Disiplinli va mas''uliyatli bo''lish',
    'Ish tajribasi bo''lsa afzal',
    'Koreys tilini boshlang''ich bilish afzal'
  ],
  array[
    'Raqobatbardosh maosh',
    'Yashash joyi bepul',
    'Tibbiy sug''urta',
    'Transport xizmati',
    'Ovqatlanish yordami',
    'Viza bo''yicha yordam'
  ],
  'Samsung Korea xalqaro texnologiya va ishlab chiqarish kompaniyasi bo''lib, xodimlar uchun barqaror ish sharoiti, o''sish imkoniyati va zamonaviy ishlab chiqarish muhitini taqdim etadi.',
  'Seul, Koreya',
  '10 000+',
  24,
  '[
    {"user_name":"Azizbek","rating":4.8,"comment":"Ish sharoiti yaxshi, yotoqxona va transport masalasi qulay.","date":"2026-05-12"},
    {"user_name":"Dilnoza","rating":4.6,"comment":"Hujjat tayyorlashda yordam berishdi, jarayon ancha tartibli.","date":"2026-04-28"}
  ]'::jsonb,
  true
),
(
  '22222222-2222-4222-8222-222222222222',
  'UI/UX Designer',
  'Google',
  true,
  'G',
  87,
  'Remote',
  '$4,500',
  'Design',
  'Remote',
  'Full-time',
  'Mahsulot dizayni, prototiplash va foydalanuvchi tajribasini yaxshilash ustida ishlaydigan dizayner kerak.',
  '2026-06-01',
  3,
  'Inglizcha (o''rta)',
  'Remote',
  array['Figma bilan ishlash', 'Portfolio mavjud bo''lishi', 'UX research asoslarini bilish'],
  array['Remote ish', 'Moslashuvchan grafik', 'Xalqaro jamoa'],
  'Google global texnologiya kompaniyasi.',
  'Remote',
  '100 000+',
  12,
  '[]'::jsonb,
  false
),
(
  '33333333-3333-4333-8333-333333333333',
  'Flutter Developer',
  'Startup AI',
  false,
  'F',
  95,
  'Toshkent',
  '$3,500',
  'IT',
  'To''liq ish vaqti',
  'Doimiy',
  'Flutter ilovalarini ishlab chiqish va Supabase bilan integratsiyalar ustida ishlaydigan mobil dasturchi qidirilmoqda.',
  '2026-06-15',
  2,
  'Inglizcha texnik hujjatlarni o''qish',
  'Berilmaydi',
  array['Flutter tajribasi', 'Riverpod yoki Provider bilish', 'REST API bilan ishlash'],
  array['Zamonaviy stack', 'Tez o''sish imkoniyati', 'Bonuslar'],
  'Startup AI ish qidirish jarayonini AI bilan soddalashtiradi.',
  'Toshkent, Uzbekistan',
  '20+',
  5,
  '[]'::jsonb,
  true
)
on conflict (id) do update set
  title = excluded.title,
  company = excluded.company,
  verified = excluded.verified,
  logo = excluded.logo,
  match_score = excluded.match_score,
  location = excluded.location,
  salary = excluded.salary,
  category = excluded.category,
  job_type = excluded.job_type,
  contract_type = excluded.contract_type,
  description = excluded.description,
  start_date = excluded.start_date,
  employees_needed = excluded.employees_needed,
  language_requirement = excluded.language_requirement,
  housing = excluded.housing,
  requirements = excluded.requirements,
  benefits = excluded.benefits,
  company_description = excluded.company_description,
  company_location = excluded.company_location,
  company_employees = excluded.company_employees,
  company_active_vacancies = excluded.company_active_vacancies,
  reviews = excluded.reviews,
  featured = excluded.featured,
  is_active = true,
  updated_at = now();
