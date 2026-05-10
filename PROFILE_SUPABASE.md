# Profil (tahrirlash) — Supabase sozlash

## 1. SQL migratsiya

Loyihada fayl: `supabase/migrations/20260511100000_profiles.sql`

**Variant A — CLI:**

```bash
supabase link --project-ref <SIZNING_REF>
supabase db push
```

**Variant B — Dashboard:**

1. **SQL Editor** oching.
2. `20260511100000_profiles.sql` ichidagi barcha SQL ni nusxalab **Run** qiling.

Bu quyidagilarni yaratadi:

- `public.profiles` jadvali (`id` = `auth.users.id`)
- **RLS**: foydalanuvchi faqat **o‘z** qatorini o‘qiydi/yangilaydi
- **Trigger**: yangi `auth.users` qatori uchun avtomatik bo‘sh `profiles` yozuvi

## 2. Tekshirish

SQL Editor:

```sql
select * from public.profiles limit 5;
```

## 3. Flutter tomonda

- `.env` da `SUPABASE_URL` va `SUPABASE_ANON_KEY` to‘g‘ri bo‘lishi kerak.
- Foydalanuvchi **OTP / email orqali** kirgan bo‘lsa (`auth` sessiyasi bor), **Saqlash** `profiles` jadvaliga yozadi.
- Faqat **Telegram mahalliy** sessiya bo‘lsa (Supabase JWT yo‘q), saqlashda xabar chiqadi — avval telefon OTP bilan kirish kerak.

## 4. Xato: `column "updated_at" does not exist`

Sababi: Dashboardda yoki oldin `profiles` jadvali ** boshqa ustunlar bilan** yaratilgan; keyingi skript esa faqat `CREATE TABLE IF NOT EXISTS` bilan jadvalni **yangilamaydi**, indeks esa `updated_at` ga yoziladi.

**Tezkor yechim:** SQL Editor da `supabase/migrations/20260511110000_profiles_hotfix_columns.sql` ni ishga tushiring.

Yoki yangilangan **`20260511100000_profiles.sql`** ni butunlay qayta ishga tushiring (ustunlar `ADD COLUMN IF NOT EXISTS` bilan qo‘shiladi).

## 5. Keyingi qadamlar (ixtiyoriy)

- **Avatar**: `avatar_url` ga Supabase **Storage** dan public URL qo‘yish (hozircha URL qo‘lda / keyin upload).
- **CV**: `cv_url` — Storage ga yuklangan fayl yo‘li.
- **Telegram ↔ profiles bog‘lash**: keyin `profiles` ga `telegram_user_id` yoki alohida mapping qo‘shish mumkin.
