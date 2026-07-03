-- Tabela de leads capturados pelo formulário do e-book Albert
create table if not exists public.leads (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  nome text not null,
  whatsapp text not null,
  email text not null,
  instagram text,
  faturamento text,       -- 'desq' ou 'qual'
  segmento text,
  como_tenta_hoje text,
  rd_station_synced boolean not null default false
);

-- Habilita Row Level Security
alter table public.leads enable row level security;

-- Permite que QUALQUER pessoa (anon) insira um novo lead
-- (necessário pois o formulário roda 100% no front-end, sem backend)
create policy "Permitir insert anonimo"
  on public.leads
  for insert
  to anon
  with check (true);

-- IMPORTANTE: não criamos policy de SELECT/UPDATE/DELETE para "anon".
-- Isso garante que ninguém consiga LER os leads de outras pessoas
-- pela chave pública (anon key) — só o dashboard do Supabase
-- (com sua conta autenticada) ou a service_role key conseguem ler.
