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
VALUES( 'Natalia', 'Yakovenko', '1983.11.11', '1akovenkonatali9@gmail.com', '+380662865172', true),
      ( 'Ruslana', 'Rovenko', '1984.10.11', '2ykovenkonatali@gmail.com', '+380986865173', true),
      ( 'Diana', 'Doenko', '1985.05.05', '3yaovenkonata@gmail.com', '+380992785174', true),
      ( 'Riana', 'Soenko', '1986.03.03', '4yakvenko@gmail.com', '+380672984176', true);

INSERT INTO users(first_name,last_name,birthday,email,tel_number,is_male)
VALUES( 'lia', 'Nion', NULL, 'li@gmail.com', '+380972865177', true);     



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

-- отримати всю інформацію
SELECT *
FROM users;

-- отримати конкретні стовпці
SELECT first_name,last_name
FROM users;

-- Призначення псевдонимів
SELECT first_name AS name, last_name AS surname
FROM users;

--Конкатинація значень
SELECT first_name ||' '|| last_name AS Fullname, email
FROM users;

-- отримати день та місяць народження з повної дати народження
SELECT first_name ||' '|| last_name AS Fullname, 
EXTRACT(DAY FROM birthday) AS day, 
EXTRACT(MONTH FROM birthday) AS MONTH
FROM users;

--вивести для користувачів їх вік
SELECT first_name ||' '|| last_name AS Fullname, 
 EXTRACT(YEAR FROM age(birthday))
   FROM users;


--отримати для кожної пари бренд/модель кількість місяців з їх виробництва 
SELECT brand ||' '|| model AS Phone,
EXTRACT(MONTH FROM age(production_date)) AS months_products
FROM phones;

--отримання різних результатів
SELECT DISTINCT first_name
FROM users;

--сортування за зростанням
SELECT first_name ||' '|| last_name AS Fullname, 
email, tel_number
FROM users
ORDER BY email;

--сортування за спаданням
SELECT first_name ||' '|| last_name AS Fullname, 
email, tel_number
FROM users
ORDER BY email DESC;

--сортувати за спаданням за декількома параметрами
SELECT first_name ||' '|| last_name AS Fullname, 
email, tel_number
FROM users
ORDER BY first_name,email;

--сортувати за зростанням перший параметр, за спаданням другий параметрам
SELECT first_name ||' '|| last_name AS Fullname, 
email, tel_number
FROM users
ORDER BY first_name,email DESC;

--впорядкувати телефони за датою виробництва
SELECT brand ||' '|| model AS Phone,
production_date
FROM phones
ORDER BY production_date DESC;

--впорядкувати за назвою місяця дати народження users
SELECT first_name ||' '|| last_name AS Fullname,
EXTRACT(DAY FROM birthday) AS day, 
EXTRACT(MONTH FROM birthday) AS MONTH, birthday
FROM users
ORDER BY EXTRACT(MONTH FROM birthday);

--впорядкувати за назвою місяця, та днем дати народження users
SELECT first_name ||' '|| last_name AS Fullname,
EXTRACT(DAY FROM birthday) AS day, 
EXTRACT(MONTH FROM birthday) AS MONTH, birthday
FROM users
ORDER BY EXTRACT(MONTH FROM birthday), EXTRACT(DAY FROM birthday);

--Пагінація, 3 рядка, після 6 рядка
SELECT *
FROM users
ORDER BY id
LIMIT 3 OFFSET 6;

--обрати телефон з найменшою ціною
SELECT *
FROM phones
ORDER BY price
LIMIT 3;
