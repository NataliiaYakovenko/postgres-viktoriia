CREATE DATABASE test;
DROP DATABASE test;
CREATE TABLE users(
    id serial,
    first_name varchar(64),
    last_name varchar(64),
    is_male boolean
);
DROP TABLE users;
DROP TABLE IS EXISTS users;
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
    birthday date CHECK (birthday >= CURRENT_DATE),
    email varchar(64) CHECK (email <> '') NOT NULL UNIQUE,
    tel_number char(13) NOT NULL UNIQUE,
    is_male boolean,
    orders_count smallint CHECK (orders_count >= 0) DEFAULT 0
);
-- Task: Описати структуру таблиці для сутності ТЕЛЕФОН (бренд, модель, ціна, колір, дата виробництва)
CREATE TABLE IF NOT EXISTS phones (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(64) NOT NULL,
    model VARCHAR(64) NOT NULL,
    color VARCHAR(64),
    production_date DATE CHECK (production_date <= CURRENT_DATE) NOT NULL,
    price NUMERIC(7, 2) CHECK (price > 0),
    UNIQUE(brand, model)
)
SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIMESTAMP;