CREATE DATABASE test;
DROP DATABASE test;
CREATE TABLE users(
    id serial,
    first_name varchar(64),
    last_name varchar(64),
    is_male boolean
);
DROP TABLE users;
DROP TABLE IF EXISTS users;
--видали таблицю якщо вона існує


CREATE TABLE IF NOT EXISTS users(
    id serial,
    first_name varchar(64),
    last_name varchar(64),
    is_male boolean
);




/* Створення таблиці (2.3, 5.1)
 * з типами даних (8)
 * з обмеженнями (5.4):
 - обмеження-перевірка CHECK (умова) - рівня стовпця чи таблиці
 - обмеження NOT NULL                - рівня стовпця
 - обмеження унікальності UNIQUE     - рівня стовпця чи таблиці
 - первинний ключ PRIMARY KEY        - рівня стовпця чи таблиці
 (первинний ключ - стовпець або набір стовпців, які однозначно ідентифікують запис(рядок))
 (може бути один на таблицю)
 (PRIMARY KEY = UNIQUE + NOT NULL)
 * та зі значеннями за замовчуванням DEFAULT (5.2)
 */
-- створи таблицю якщо вона не існує
CREATE TABLE IF NOT EXISTS users(
    id serial PRIMARY KEY,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    birthday date CHECK (birthday <= CURRENT_DATE),
    email varchar(64) CHECK (email <> '') NOT NULL UNIQUE,
    tel_number char(13) NOT NULL UNIQUE,
    is_male boolean,
    orders_count smallint CHECK (orders_count >= 0) DEFAULT 0
);

INSERT INTO users(first_name,last_name,birthday,email,tel_number,is_male)
VALUES( 'Natalia', 'Yakovenko', '1983.10.14', 'yakovenkonatali99@gmail.com', '+380662865139', true);

INSERT INTO users(first_name,last_name,birthday,email,tel_number,is_male)
VALUES( 'Natalia', 'Yakovenko', '1983.10.14', 'yakovenkonatali9@gmail.com', '+380662865179', true),
      ( 'Natalia', 'Yakovenko', '1983.10.14', 'yakovenkonatali@gmail.com', '+380666865179', true),
      ( 'Natalia', 'Yakovenko', '1983.10.14', 'yakovenkonata@gmail.com', '+380662785179', true),
      ( 'Natalia', 'Yakovenko', '1983.10.14', 'yakovenko@gmail.com', '+380662984179', true);



-- Task: Описати структуру таблиці для сутності ТЕЛЕФОН (бренд, модель, ціна, колір, дата виробництва)
CREATE TABLE IF NOT EXISTS phones (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(64) NOT NULL,
    model VARCHAR(64) NOT NULL,
    color VARCHAR(64),
    production_date DATE CHECK (production_date <= CURRENT_DATE) NOT NULL,
    price NUMERIC(7, 2) CHECK (price > 0),
    UNIQUE(brand, model)
);

INSERT INTO phones(brand,model,color,production_date,price)
VALUES('Sumsung', 'X5', 'red', '2020.11.09', 10500.50),
      ('Sumsung', 'X6', 'black', '2021.05.24', 22500.50),
      ('Sumsung', 'X7', 'blue', '2022.02.19', 18500.50);


SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIMESTAMP;