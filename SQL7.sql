
users <- orders <- phones_to_orders -> phones

-- Створюємо в порядку від головних до залежних
-- Видаляємо в звоторньому
CREATE DATABASE phones_sales;

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    email varchar(64) CHECK (email <> ''),
    tel char(13) NOT NULL UNIQUE CHECK(tel LIKE '+380_________')
);
INSERT INTO users(first_name, last_name, email, tel)
VALUES('Petro1','Petrenko1','test1@test.test','+380983456789'),
    ('Petro2', 'Petrenko2', 'test2@test.test', '+380993456789'),
    ('Petro3', 'Petrenko3','test3@test.test', '+380933456789'),
    ('Petro4','Petrenko4', 'test4@test.test', '+380503456789'),
    ( 'Petro5', 'Petrenko5', 'test5@test.test', '+380633456789' ),
    ( 'Petro6', 'Petrenko6', 'test6@test.test', '+380683456789' ),
    (  'Petro7',  'Petrenko7',  'test7@test.test',  '+380443456789'),
    (  'Petro8',  'Petrenko8',  'test8@test.test',  '+380663456789' ),
    (  'Petro9',  'Petrenko9',  'test9@test.test',  '+380733456789');

CREATE TABLE phones (
  id SERIAL PRIMARY KEY,
  brand VARCHAR(32) NOT NULL,
  model VARCHAR(32) NOT NULL,
  price numeric(10,2) CHECK (price > 0) NOT NULL,
  color VARCHAR(32), 
  manufactured_year SMALLINT CHECK (manufactured_year <= EXTRACT(YEAR FROM CURRENT_DATE) 
                                    AND manufactured_year >= 1970),
  UNIQUE(brand, model)
);

INSERT INTO phones(brand, model, price, color, manufactured_year)
VALUES ('Samsung', 'GALAXY1', 600.0, 'blue', 2015),
       ('Samsung', 'GALAXY2', 300.0, 'white', 2019),
       ('Samsung', 'GALAXY3', 400.0, 'blue', 2020),
       ('Samsung', 'GALAXY4', 500.0, 'white', 2021),
       ('IPhone', '7', 1800.0, 'blue', 2015),
       ('IPhone', '8', 1200.0, 'white', 2019),
       ('IPhone', '9', 1300.0, 'blue', 2020),
       ('IPhone', 'X', 2000.0, 'white', 2021),
       ('IPhone', '15', 3000.0, 'blue', 2021);     


 CREATE TABLE orders(
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    created_at DATE NOT NULL CHECK(created_at <= CURRENT_DATE ) DEFAULT CURRENT_DATE
 );

 INSERT INTO orders(user_id, created_at)
 VALUES(1, '2023-03-05'),
       (2, '2022-04-01'),
       (3, '2021-02-10'),
       (4, '2023-07-17'),
       (5, '2022-01-22'),
       (6, '2021-12-15'),
       (7, '2023-08-09');

CREATE TABLE phones_to_orderes(
     id SERIAL PRIMARY KEY,
     order_id INTEGER REFERENCES orders(id) ON UPDATE CASCADE ON DELETE RESTRICT, 
     phone_id INTEGER REFERENCES phones(id) ON UPDATE CASCADE ON DELETE RESTRICT, 
     amount smallint CHECK (amount >= 0));

INSERT INTO phones_to_orderes (phone_id, order_id, amount)
VALUES (1, 6, 1),
       (1, 2, 1),
       (2, 2, 1),
       (3, 4, 1),
       (7, 4, 2),
       (9, 5, 3),
       (8, 5, 2);
    
-- Ex: Вивести інформацію про користувачів і їх замовлення
SELECT *
FROM orders INNER JOIN users ON orders.user_id=users.id;

-- Task: Вивести інфо про телефони і в якій кількості їх купували
SELECT *
FROM phones INNER JOIN phones_to_orderes AS pto ON pto.phone_id=phones.id;

--Вивести скільки яких телефонів купили
SELECT brand, model, sum(amount) AS total_amount
FROM phones INNER JOIN phones_to_orderes AS pto ON pto.phone_id=phones.id
GROUP BY brand, model
ORDER BY total_amount DESC;

--Вивести кількість замовлень кожного користувача
SELECT user_id,users.first_name,users.last_name, count(*) AS count
FROM orders INNER JOIN users ON orders.user_id=users.id
GROUP BY user_id, users.first_name,users.last_name
ORDER BY count DESC;     

--Вивести інформацію про сумарну вартість проданих телефонів кожної моделі
SELECT model, sum(price*amount) AS sum
FROM phones INNER JOIN phones_to_orderes AS pto ON pto.phone_id=phones.id
GROUP BY model
ORDER BY sum DESC;

--Яку сумарну кількість телефонів купили різних брендів
SELECT brand, sum(amount)
FROM phones INNER JOIN phones_to_orderes AS pto ON pto.phone_id=phones.id
GROUP BY brand;

--Яку сумарну кількість телефонів купили різних брендів 2021 року виготовлення
SELECT brand, sum(amount)
FROM phones INNER JOIN phones_to_orderes AS pto ON pto.phone_id=phones.id
WHERE manufactured_year = 2021
GROUP BY brand;