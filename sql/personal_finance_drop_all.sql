-- 1. Tabelas com chaves estrangeiras (Dependentes)
DROP TABLE IF EXISTS tb_fixed_payment;
DROP TABLE IF EXISTS tb_temp_payment;

-- 2. Tabelas de domínio/suporte (Referenciadas)
DROP TABLE IF EXISTS tb_payment_category;
DROP TABLE IF EXISTS tb_payment_type;
DROP TABLE IF EXISTS tb_payment_bank;