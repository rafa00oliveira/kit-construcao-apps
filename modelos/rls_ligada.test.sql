-- Copie para supabase/tests/rls_ligada.test.sql (MANUAL-CONSTRUCAO.md, P5.9).
-- Roda com `supabase test db`, no banco local (`supabase start`). Falha listando a tabela do public sem RLS.
begin;
select plan(1);

select is_empty(
  $$ select tablename from pg_tables where schemaname = 'public' and not rowsecurity $$,
  'toda tabela do public tem RLS ligada'
);

select * from finish();
rollback;
