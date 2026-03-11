INSERT INTO tb_payment_category (name) VALUES
('Alimentação'),
('Transporte'),
('Moradia'),
('Saúde'),
('Educação'),
('Lazer'),
('Roupas e Acessórios'),
('Tecnologia'),
('Investimentos'),
('Trabalho'),
('Streaming');

INSERT INTO tb_payment_type (name) VALUES
('Cartão de Crédito'),
('Cartão de Débito'),
('Dinheiro'),
('Transferência Bancária'),
('Pix');

INSERT INTO tb_payment_bank (name) VALUES
('Banco do Brasil'),
('Caixa Econômica Federal'),
('Bradesco'),
('Itaú Unibanco'),
('Santander'),
('Nubank'),
('Inter'),
('C6 Bank');

INSERT INTO tb_fixed_payment (name, expense_value, income_value, bank_id, category_id, payment_type_id) VALUES
(
  'Salário', 0.00, 7000.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Itaú Unibanco'),
  (SELECT id FROM tb_payment_category WHERE name = 'Trabalho'),
  (SELECT id FROM tb_payment_type WHERE name = 'Transferência Bancária')
),
(
  'Aluguel (Vó)', 500.00, 0.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Inter'),
  (SELECT id FROM tb_payment_category WHERE name = 'Moradia'),
  (SELECT id FROM tb_payment_type WHERE name = 'Transferência Bancária')
),
(
  'Academia', 109.90, 0.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Inter'),
  (SELECT id FROM tb_payment_category WHERE name = 'Saúde'),
  (SELECT id FROM tb_payment_type WHERE name = 'Cartão de Crédito')
),
(
  'Internet Móvel', 30.00, 0.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Inter'),
  (SELECT id FROM tb_payment_category WHERE name = 'Lazer'),
  (SELECT id FROM tb_payment_type WHERE name = 'Cartão de Débito')
),
(
  'Spotify', 40.90, 0.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Inter'),
  (SELECT id FROM tb_payment_category WHERE name = 'Streaming'),
  (SELECT id FROM tb_payment_type WHERE name = 'Cartão de Crédito')
),
(
  'Cinemark Club', 38.90, 0.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Inter'),
  (SELECT id FROM tb_payment_category WHERE name = 'Lazer'),
  (SELECT id FROM tb_payment_type WHERE name = 'Cartão de Crédito')
),
(
  '% de Investimento', 700.00, 0.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Inter'),
  (SELECT id FROM tb_payment_category WHERE name = 'Investimentos'),
  (SELECT id FROM tb_payment_type WHERE name = 'Cartão de Débito')
),
(
  'Netflix', 44.90, 0.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Inter'),
  (SELECT id FROM tb_payment_category WHERE name = 'Streaming'),
  (SELECT id FROM tb_payment_type WHERE name = 'Cartão de Crédito')
),
(
  'Apple TV (Prime)', 29.90, 0.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Inter'),
  (SELECT id FROM tb_payment_category WHERE name = 'Streaming'),
  (SELECT id FROM tb_payment_type WHERE name = 'Cartão de Crédito')
),
(
  'Crunchyroll', 19.90, 0.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Inter'),
  (SELECT id FROM tb_payment_category WHERE name = 'Streaming'),
  (SELECT id FROM tb_payment_type WHERE name = 'Cartão de Crédito')
),
(
  'Disney+', 46.90, 0.00,
  (SELECT id FROM tb_payment_bank WHERE name = 'Inter'),
  (SELECT id FROM tb_payment_category WHERE name = 'Streaming'),
  (SELECT id FROM tb_payment_type WHERE name = 'Cartão de Crédito')
);