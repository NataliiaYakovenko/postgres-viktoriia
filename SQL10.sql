-- Умовні 
-- CASE

CREATE TABLE users1(
   id SERIAL PRIMARY KEY,
   name varchar(60),
   is_male boolean
);

INSERT INTO users1 (name, is_male)
VALUES ('John Smithko', true),
       ('John Smithky', true),
       ('Anny Smithko', false),
       ('Anny Smithov', false),
       ('Anny Smith', null);


-- 1Ex: Вивести замість булевського значення гендера рядкове 
SELECT id, name, CASE is_male
                  WHEN true THEN 'male'
                  WHEN false THEN 'female'
                  ELSE 'other'
                  END AS gender
FROM users1;

-- 2Ex: Вивести замість булевського значення гендера рядкове 
SELECT id, name, CASE 
                  WHEN is_male = true THEN 'male'
                  WHEN is_male = false THEN 'female'
                  ELSE 'other'
                  END AS gender
FROM users1;


-- Task: Вивести користувачів у вигляді
-- id name  is_male
-- 1  ***ko true
-- 2  ***ky true
-- ...
-- 5  ***** false

SELECT id, is_male, CASE is_male
                    WHEN true THEN '***ko'
                    WHEN true THEN '***ky'
                    ELSE '*****'
                    END AS gender
FROM users1;


-- Поєднання запитів (7.4)
CREATE TABLE basket_a (
     a INT PRIMARY KEY,
     fruit_a VARCHAR (100) NOT NULL
);

CREATE TABLE basket_b (
     b INT PRIMARY KEY,
     fruit_b VARCHAR (100) NOT NULL
);

INSERT INTO basket_a (a, fruit_a)
VALUES
     (1, 'Apple'),
     (2, 'Orange'),
     (3, 'Banana'),
     (4, 'Cucumber');

INSERT INTO basket_b (b, fruit_b)
VALUES
     (1, 'Orange'),
     (2, 'Apple'),
     (3, 'Watermelon'),
     (4, 'Pear');



-- Об'єднання: є хоч десь
SELECT fruit_a
FROM basket_a    
UNION             -- не вдображає дублікати
SELECT fruit_b
FROM basket_b ;

-- Перетин: є і там, і там
SELECT fruit_a
FROM basket_a    
INTERSECT     --вдображає дублікати
SELECT fruit_b
FROM basket_b ;


-- Виключення: є в першому, але нема в другому
SELECT fruit_a
FROM basket_a    
EXCEPT
SELECT fruit_b
FROM basket_b ;

SELECT fruit_b
FROM basket_b    
EXCEPT
SELECT fruit_a
FROM basket_a ;