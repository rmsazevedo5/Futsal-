-- MODICUS PERFORMANCE: executar no SQL Editor do Supabase

create table if not exists public.modicus_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.modicus_state enable row level security;

drop policy if exists "read own modicus state" on public.modicus_state;
create policy "read own modicus state"
on public.modicus_state for select
using (auth.uid() = user_id);

drop policy if exists "insert own modicus state" on public.modicus_state;
create policy "insert own modicus state"
on public.modicus_state for insert
with check (auth.uid() = user_id);

drop policy if exists "update own modicus state" on public.modicus_state;
create policy "update own modicus state"
on public.modicus_state for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- Criar bucket privado para os vídeos.
insert into storage.buckets (id, name, public)
values ('game-videos','game-videos',false)
on conflict (id) do nothing;

drop policy if exists "users upload own game videos" on storage.objects;
create policy "users upload own game videos"
on storage.objects for insert to authenticated
with check (bucket_id='game-videos' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "users update own game videos" on storage.objects;
create policy "users update own game videos"
on storage.objects for update to authenticated
using (bucket_id='game-videos' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "users read own game videos" on storage.objects;
create policy "users read own game videos"
on storage.objects for select to authenticated
using (bucket_id='game-videos' and (storage.foldername(name))[1] = auth.uid()::text);
