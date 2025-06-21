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


--пошук шаблонів LIKE , ILIKE
-- % - будь - яка кількість будь - яких символів
--  _  - один будь-який символ

-- знайти користувача з ім'ям Ruslana
SELECT *
FROM users
WHERE first_name LIKE 'Ruslana';


-- знайти користувача з ім'ям , яке починається на Dian
SELECT *
FROM users
WHERE first_name LIKE 'Dian_';


-- знайти користувачів, у яких email починається НЕ на yakovenko
SELECT *
FROM users
WHERE email NOT LIKE 'yakovenko%';

-- знайти користувачів, у яких email має в будь-якому місці параметри "yakovenko"
SELECT *
FROM users
WHERE email LIKE '%yakovenko%';

--знайти користувачів, які мають операторів водафон 050, 066, 099, 095
SELECT *
FROM users
WHERE tel_number LIKE '+38050%' OR
      tel_number LIKE '+38066%' OR
      tel_number LIKE '+38099%' OR
      tel_number LIKE '+38095%';

 -- Перевірка на приналежність інтервалу діапозону
 --BETWEEN...AND
 
 --знайти користувачів які народились 1984, 1985,1986
 SELECT *
FROM users
WHERE birthday BETWEEN '1984-01-01' AND '1986-12-31';

 --Знайдіть користувачів в діапозоні між  40 і 41
SELECT *
FROM users
WHERE EXTRACT(YEAR FROM AGE(birthday)) BETWEEN '40' AND '41';
  
--Знайдіть користувачів до 39 і після 40
SELECT *
FROM users
WHERE EXTRACT(YEAR FROM AGE(birthday)) NOT BETWEEN '39' AND '40';


 -- Перевірка на приналежність списку значень
 -- IN

 --відобразити корисувачів з іменами 'Diana', 'Riana'
SELECT *
FROM users
WHERE first_name IN ('Diana', 'Riana');

 --відобразити корисувачів з НЕ іменами 'Diana', 'Riana'
SELECT *
FROM users
WHERE first_name NOT IN ('Diana', 'Riana');


--порівняння з NULL
--IS NULL
--ISNULL
--IS NOT NULL
--NOTNULL

--Перевірити у кого не вказане birthday
SELECT *
FROM users
WHERE birthday IS NULL;

--Перевірити у кого вказане birthday
SELECT *
FROM users
WHERE birthday IS NOT NULL;
