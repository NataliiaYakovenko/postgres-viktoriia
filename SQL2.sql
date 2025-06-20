-- Філтрація - WHERE

--Порівняння > , <, >=, <=, =, <> {!=}
SELECT *
FROM users
WHERE first_name = 'Ruslana';

--вибрати юзерів хто нарожився до 1984
SELECT *
FROM users 
WHERE birthday < '1984-01-01';

--зробити розсилку на всі email крім одного
SELECT email
FROM users
WHERE email <> '3yaovenkonata@gmail.com';

--логічні оператори AND, OR, NOT
--отримати конкретне ім'я і прізвище
SELECT *
FROM users
WHERE first_name = 'Diana' AND last_name = 'Doenko';

--знайти користувачів які народились 1984, 1985,1986
SELECT *
FROM users
WHERE EXTRACT(YEAR FROM birthday) >= '1984' AND
      EXTRACT(YEAR FROM birthday) <= '1986';

 --Знайдіть користувачів до 39 і після 41
SELECT *
FROM users
WHERE EXTRACT(YEAR FROM AGE(birthday)) >= '41' OR
      EXTRACT(YEAR FROM AGE(birthday)) <= '39';
