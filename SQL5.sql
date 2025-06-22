--додавання стовпчика
ALTER TABLE employees
ADD COLUMN tel_number CHAR(13) CHECK(tel_number LIKE'+380000000000');

ALTER TABLE employees
DROP COLUMN tel_number;

INSERT INTO employees (last_name, first_name, email, birthday, gender, salary,tel_number)
VALUES ('Ivanov', 'Timur', 'ivanov@gmail.com', '1993-01-01', 'male', 10000.00,'+380000000000')
RETURNING *;

--оновлення даних
-- збільити заробітну платуна 1.2
UPDATE employees
SET salary = salary * 1.2;


--змінити співробітнику email
UPDATE employees
SET email = 'cat@gmail.com'
WHERE id = 7;

-- підвищити заробітну плату жінками на 10%
UPDATE employees
SET salary = salary * 1.10
WHERE gender = 'female';

--побачити всютаблицю зі змненими зарплатами
UPDATE employees
SET salary = salary * 1.2
RETURNING *;

UPDATE employees
SET salary = salary * 1.2
RETURNING first_name;


--видалення даних
DELETE FROM employees
WHERE id = 1
RETURNING *;