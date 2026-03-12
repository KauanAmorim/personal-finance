CREATE OR REPLACE VIEW vw_detailed_fixed_payments AS
SELECT
  tb_fixed_payment.id,
  tb_fixed_payment.name,
  tb_fixed_payment.expense_value,
  tb_fixed_payment.income_value,
  tb_payment_bank.name AS bank_name,
  tb_payment_category.name AS category_name,
  tb_payment_type.name AS payment_type_name
FROM tb_fixed_payment
INNER JOIN tb_payment_bank ON tb_fixed_payment.bank_id = tb_payment_bank.id
INNER JOIN tb_payment_category ON tb_fixed_payment.category_id = tb_payment_category.id
INNER JOIN tb_payment_type ON tb_fixed_payment.payment_type_id = tb_payment_type.id
ORDER BY tb_fixed_payment.payment_type_id, tb_fixed_payment.id;


CREATE OR REPLACE VIEW vw_detailed_temp_payments AS
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
INNER JOIN tb_payment_type ON tb_temp_payment.payment_type_id = tb_payment_type.id;


DROP VIEW IF EXISTS vw_fixed_balance;
CREATE OR REPLACE VIEW vw_fixed_balance AS
SELECT
  SUM(expense_value) AS total_expenses,
  SUM(income_value) AS total_incomes,
  SUM(income_value) - SUM(expense_value) AS total_fixed_balance
FROM tb_fixed_payment;


DROP VIEW IF EXISTS vw_current_month_balance;
CREATE OR REPLACE VIEW vw_current_month_balance AS
SELECT
  SUM(expense_value) AS total_expenses,
  SUM(income_value) AS total_incomes,
  SUM(income_value) - SUM(expense_value) AS total_current_month_balance
FROM tb_temp_payment
WHERE at_date >= DATE_TRUNC('month', now())
  AND at_date < DATE_TRUNC('month', now()) + INTERVAL '1 month';


DROP VIEW IF EXISTS vw_total_current_month_balance;
CREATE OR REPLACE VIEW vw_total_current_month_balance AS
SELECT
  vw_fixed_balance.total_fixed_balance,
  vw_current_month_balance.total_current_month_balance,
  (vw_fixed_balance.total_fixed_balance + vw_current_month_balance.total_current_month_balance) AS total_balance
FROM vw_fixed_balance
CROSS JOIN vw_current_month_balance;



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

DROP VIEW IF EXISTS vw_total_expenses_by_category;
CREATE OR REPLACE VIEW vw_total_expenses_by_category AS
SELECT
  tb_payment_category.*,
  vtb_fixed_category_expenses.total_expenses AS total_fixed_expenses,
  vtb_temp_category_expenses.total_expenses AS total_temp_expenses
FROM tb_payment_category
LEFT JOIN
  (SELECT category_id, SUM(expense_value) AS total_expenses FROM tb_fixed_payment GROUP BY category_id) as vtb_fixed_category_expenses
ON vtb_fixed_category_expenses.category_id = tb_payment_category.id
LEFT JOIN 
  (SELECT category_id, SUM(expense_value) AS total_expenses FROM tb_temp_payment GROUP BY category_id) as vtb_temp_category_expenses
ON vtb_temp_category_expenses.category_id = tb_payment_category.id;

DROP VIEW IF EXISTS vw_total_fixed_expenses_by_category;
CREATE OR REPLACE VIEW vw_total_fixed_expenses_by_category AS
SELECT
  tb_payment_category.*,
  vtb_fixed_category_expenses.total_expenses AS total_fixed_expenses
FROM tb_payment_category
INNER JOIN
  (SELECT category_id, SUM(expense_value) AS total_expenses FROM tb_fixed_payment GROUP BY category_id) as vtb_fixed_category_expenses
ON vtb_fixed_category_expenses.category_id = tb_payment_category.id;

DROP VIEW IF EXISTS vw_total_expenses_current_month_by_category;
CREATE OR REPLACE VIEW vw_total_expenses_current_month_by_category AS
SELECT
  tb_payment_category.*,
  vtb_temp_category_expenses.total_current_month_expenses
FROM tb_payment_category
INNER JOIN
  (SELECT
    category_id,
    SUM(expense_value) AS total_current_month_expenses
  FROM tb_temp_payment
  WHERE
    expense_value > 0
    AND at_date >= DATE_TRUNC('month', now())
    AND at_date < DATE_TRUNC('month', now()) + INTERVAL '1 month'
  GROUP BY category_id) as vtb_temp_category_expenses
ON vtb_temp_category_expenses.category_id = tb_payment_category.id;