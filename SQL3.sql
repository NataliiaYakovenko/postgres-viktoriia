--Практика

 SELECT
 FROM
 WHERE
 ORDER BY
 LIMIT OFF SET

 -- знайти прізвище і дату народження користувачив з явно вказаним прізвищем,
 -- які народились в січні
 -- і впорядкувати за прізвищем
 -- і відобразити 3 і 4 результати

SELECT last_name, birthday
FROM users
WHERE last_name IS NOT NULL AND EXTRACT (MONTH FROM birthday) = 10
ORDER BY last_name
LIMIT 2 OFFSET 2;
//-------------------------------------------------------------------------

--Создать табл. employees (id, fn, ln, email, birthday, gender, salary)

CREATE TYPE gender_type AS ENUM ('male', 'female', 'other');

CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  first_name varchar(30) NOT NULL,
  last_name varchar(30) NOT NULL,
  email varchar(50) CHECK (email <> ''),
  birthday date NOT NULL CHECK (birthday < current_date),
  gender gender_type NOT NULL,
  salary numeric(10,2) NOT NULL DEFAULT 6000.00
);

DROP TABLE employees;

INSERT INTO employees (last_name, first_name, email, birthday, gender, salary)
VALUES ('Ivanov', 'Timur', 'ivanov@gmail.com', '1993-01-01', 'male', 10000.00),
       ('Avramenko', 'Timur', NULL, '2002-01-22', 'male', 12000.00),
       ('Smirnova', 'Svetlana', 'sveta@gmail.com', '1994-10-14', 'female', 9000.00),
       ('Kulik', 'Petr', NULL, '2001-01-05', 'male', 14000.00),
       ('Goncharova', 'Maria', 'mashka@gmail.com', '1989-03-14', 'female', 12000.00),
       ('Naumenko', 'Roman', NULL, '1960-02-08', 'other', 8000.00),
       ('Naumenko', 'Maksim', 'roma@gmail.com', '1980-03-31', 'male', 25000.00);

 INSERT INTO employees (last_name, first_name, email, birthday, gender, salary)
VALUES     ('Avramenko', 'Timur', NULL, '2002-01-22', 'male', 12000.00),
           ('Kulik', 'Petr', NULL, '2001-01-05', 'male', 14000.00);
     

 -- Task 1 Відобразити всіх співробітників, 
 --прізвище яких починається на A і закінчується на kо / Avramenko, Adelko, Ako  
SELECT last_name
FROM employees
WHERE last_name LIKE 'A%ko' ;
  


--Task 2 Відобразити всіх співробітників, 
--які народилися раніше 2000 року та впорядкувати їх за прізвищем.
-- Якщо прізвище однакове, то за ім'ям     
SELECT first_name, last_name,birthday
FROM employees
WHERE birthday < '2000-01-01'
ORDER BY last_name, first_name;


-- Task 3 Відобразити ім'я, прізвище та вік співробітників, 
-- ім'я яких починається з Т, 
-- а прізвище містить o, /Okhrimenko, Tolok
-- упорядковані за віком від молодшого до старшого
SELECT first_name, last_name,birthday
FROM employees
WHERE first_name LIKE 'T%' AND 
      last_name ILIKE '%o%'
ORDER BY birthday DESC;     


-- Task 4 Відобразити всіх співробітників, які народилися 1960 року
SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM birthday) = 1960;

-- Task 5 Відобразити 2 найстарших співробітника віком від 21 до 25 років
SELECT *
FROM employees
WHERE EXTRACT (YEAR FROM AGE(birthday)) BETWEEN 21 AND 25
ORDER BY birthday
LIMIT 2;


-- Task 6 Відобразити співробітників без email, які народилися в січні 
SELECT *
FROM employees
WHERE email IS NULL AND
     EXTRACT(MONTH FROM birthday) = 01;
 