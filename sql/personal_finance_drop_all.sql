-- ==========================================
-- SCRIPT DE LIMPEZA (DROP ALL)
-- Ordem de exclusão: Views -> Tabelas Filhas -> Tabelas Pais
-- ==========================================

-- 1. Primeiro as Views que dependem de outras Views (A ponta da pirâmide)
DROP VIEW IF EXISTS vw_total_current_month_balance;

-- 2. Depois as Views base (que dependem apenas das tabelas)
DROP VIEW IF EXISTS vw_current_month_balance;
DROP VIEW IF EXISTS vw_fixed_balance;
DROP VIEW IF EXISTS vw_total_temp_expenses_by_category_current_month;
DROP VIEW IF EXISTS vw_total_fixed_expenses_by_category;
DROP VIEW IF EXISTS vw_total_expenses_by_category;
DROP VIEW IF EXISTS vw_current_month_incomes;
DROP VIEW IF EXISTS vw_current_month_expenses;
DROP VIEW IF EXISTS vw_detailed_temp_payments;
DROP VIEW IF EXISTS vw_detailed_fixed_payments;

-- 3. Em seguida as Tabelas "Filhas" (As que possuem as Foreign Keys)
DROP TABLE IF EXISTS tb_temp_payment;
DROP TABLE IF EXISTS tb_fixed_payment;

-- 4. Por fim, as Tabelas "Pais" (As tabelas de domínio/cadastros base)
DROP TABLE IF EXISTS tb_payment_bank;
DROP TABLE IF EXISTS tb_payment_type;
DROP TABLE IF EXISTS tb_payment_category;

-- Opcional: Se quiser resetar sequências órfãs, caso existam, adicione a flag CASCADE nos drops das tabelas:
-- Exemplo: DROP TABLE IF EXISTS tb_payment_category CASCADE;