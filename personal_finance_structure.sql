CREATE TABLE IF NOT EXISTS tb_payment_category (
	id SERIAL,
	name VARCHAR(255) NOT NULL,
	CONSTRAINT pk_tb_payment_category PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tb_payment_type (
	id SERIAL,
	name VARCHAR(255) NOT NULL,
	CONSTRAINT pk_tb_payment_type PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tb_payment_bank (
	id SERIAL,
	name VARCHAR(255) NOT NULL,
	CONSTRAINT pk_tb_payment_bank PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tb_fixed_payment (
	id SERIAL,
	name VARCHAR(255) NOT NULL,
	expense_value DECIMAL(12,2) NOT NULL,
	income_value DECIMAL(12,2) NOT NULL,
	bank_id INT NOT NULL,
	category_id INT NOT NULL,
	payment_type_id INT NOT NULL,
	CONSTRAINT pk_tb_fixed_payment_id PRIMARY KEY (id),
	CONSTRAINT fk_tb_fixed_payment_bank_id_from_tb_payment_bank_id FOREIGN KEY (bank_id) REFERENCES tb_payment_bank(id),
	CONSTRAINT fk_tb_fixed_payment_category_id_from_tb_payment_category_id FOREIGN KEY (category_id) REFERENCES tb_payment_category(id),
	CONSTRAINT fk_tb_fixed_payment_payment_type_id_from_tb_payment_type_id FOREIGN KEY (payment_type_id) REFERENCES tb_payment_type(id)
);

CREATE TABLE IF NOT EXISTS tb_temp_payment (
	id SERIAL,
	name VARCHAR(255) NOT NULL,
	justification VARCHAR(1000) NOT NULL,
	expense_value DECIMAL(12,2) NOT NULL,
	income_value DECIMAL(12,2) NOT NULL,
	at_date TIMESTAMPTZ NOT NULL DEFAULT now(),
	bank_id INT NOT NULL,
	category_id INT NOT NULL,
	payment_type_id INT NOT NULL,
	CONSTRAINT pk_tb_temp_payment PRIMARY KEY (id),
	CONSTRAINT fk_tb_temp_payment_bank_id_from_tb_payment_bank_id FOREIGN KEY (bank_id) REFERENCES tb_payment_bank(id),
	CONSTRAINT fk_tb_temp_payment_category_id_from_tb_payment_category_id FOREIGN KEY (category_id) REFERENCES tb_payment_category(id),
	CONSTRAINT fk_tb_temp_payment_payment_type_id_from_tb_payment_type_id FOREIGN KEY (payment_type_id) REFERENCES tb_payment_type(id)
);
