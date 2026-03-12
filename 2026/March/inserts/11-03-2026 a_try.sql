INSERT INTO tb_temp_payment (name, justification, expense_value, income_value, bank_id, category_id, payment_type_id) VALUES
(
  'Teste de Pagamento Temporário', 'Justificativa para o pagamento temporário de teste', 150.00, 0.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Inter'),
  (SELECT id FROM tb_payment_category WHERE name = 'Lazer'),
  (SELECT id FROM tb_payment_type WHERE name = 'Cartão de Crédito')
);


SELECT * FROM tb_payment_category;

-- 1...11
SELECT * FROM tb_temp_payment;

SELECT now();


DROP VIEW vw_current_month_expenses;
CREATE VIEW vw_current_month_expenses AS
SELECT
  tb_temp_payment.id,
  tb_temp_payment.name,
  tb_temp_payment.justification,
  tb_temp_payment.expense_value,
  tb_temp_payment.income_value,
  tb_temp_payment.at_date,
  tb_payment_bank.name AS bank_name,
  tb_payment_category.name AS category_name,
  tb_payment_type.name AS payment_type_name
FROM tb_temp_payment
INNER JOIN tb_payment_bank ON tb_temp_payment.bank_id = tb_payment_bank.id
INNER JOIN tb_payment_category ON tb_temp_payment.category_id = tb_payment_category.id
INNER JOIN tb_payment_type ON tb_temp_payment.payment_type_id = tb_payment_type.id
WHERE
  expense_value > 0
  AND at_date >= DATE_TRUNC('month', now())
  AND at_date < DATE_TRUNC('month', now()) + INTERVAL '1 month';


DROP VIEW vw_current_month_incomes;
CREATE VIEW vw_current_month_incomes AS
SELECT
  tb_temp_payment.id,
  tb_temp_payment.name,
  tb_temp_payment.justification,
  tb_temp_payment.expense_value,
  tb_temp_payment.income_value,
  tb_temp_payment.at_date,
  tb_payment_bank.name AS bank_name,
  tb_payment_category.name AS category_name,
  tb_payment_type.name AS payment_type_name
FROM tb_temp_payment
INNER JOIN tb_payment_bank ON tb_temp_payment.bank_id = tb_payment_bank.id
INNER JOIN tb_payment_category ON tb_temp_payment.category_id = tb_payment_category.id
INNER JOIN tb_payment_type ON tb_temp_payment.payment_type_id = tb_payment_type.id
WHERE
  income_value > 0
  AND at_date >= DATE_TRUNC('month', now())
  AND at_date < DATE_TRUNC('month', now()) + INTERVAL '1 month';

-- Fazer view de saldo total do mês corrente vw_current_month_balance.