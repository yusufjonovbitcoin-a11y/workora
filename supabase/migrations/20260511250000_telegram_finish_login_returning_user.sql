-- Qayta kirishda bot xabari: avval mavjud telegram_users bo‘lsa returning_user = true

create or replace function public.workora_telegram_finish_login(
  p_token text,
  p_telegram_id bigint,
  p_username text,
  p_first_name text,
  p_last_name text,
  p_photo_url text
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  r record;
  v_role text;
  n int;
  v_returning boolean := false;
begin
  if p_token is null or p_telegram_id is null then
    return jsonb_build_object('ok', false, 'reason', 'bad_input');
  end if;

  select exists(
    select 1 from public.telegram_users tu where tu.telegram_id = p_telegram_id
  )
  into v_returning;

  select id, used, status, expires_at
  into r
  from public.telegram_login_tokens
  where token = trim(p_token)
  for update;

  if not found then
    return jsonb_build_object('ok', false, 'reason', 'not_found');
  end if;

  if r.used or r.status <> 'pending' or r.expires_at <= now() then
    return jsonb_build_object('ok', false, 'reason', 'bad_state');
  end if;

  select tu.role into v_role
  from public.telegram_users tu
  where tu.telegram_id = p_telegram_id;

  if not found then
    v_role := 'job_seeker';
  end if;

  insert into public.telegram_users (
    telegram_id, username, first_name, last_name, photo_url, role, updated_at
  )
  values (
    p_telegram_id,
    nullif(p_username, ''),
    nullif(p_first_name, ''),
    nullif(p_last_name, ''),
    nullif(p_photo_url, ''),
    v_role,
    now()
  )
  on conflict (telegram_id) do update set
    username = coalesce(excluded.username, telegram_users.username),
    first_name = coalesce(excluded.first_name, telegram_users.first_name),
    last_name = coalesce(excluded.last_name, telegram_users.last_name),
    photo_url = coalesce(excluded.photo_url, telegram_users.photo_url),
    updated_at = excluded.updated_at;

  update public.telegram_login_tokens
  set
    status = 'confirmed',
    telegram_id = p_telegram_id,
    used = true
  where id = r.id
    and used = false
    and status = 'pending'
    and expires_at > now();

  get diagnostics n = row_count;
  if n = 0 then
    return jsonb_build_object('ok', false, 'reason', 'race');
  end if;

  return jsonb_build_object('ok', true, 'returning_user', v_returning);
end;
$$;

notify pgrst, 'reload schema';
