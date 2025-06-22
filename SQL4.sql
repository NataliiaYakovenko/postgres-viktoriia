-- Агрегатна функція

-- порахувати скільки юзерів
SELECT count(id) AS Users count
FROM users;

-- порахувати середній вік користувачів
SELECT AVG(EXTRACT (YEAR FROM AGE(birthday))) AS "Average age"
FROM users;


--порахувати мінімальну максимальну заробітну плату
SELECT MAX(salary)
FROM employees;

SELECT MIN(salary)
FROM employees;


--дізнатися максимальну з/п чоловіків і максимальну з/п жінок
SELECT MAX(salary) 
FROM employees
WHERE gender = 'female';

SELECT MAX(salary) 
FROM employees
WHERE gender = 'male';

--Визначити кількість співробітників, у яких день народження в січні
SELECT count(id)
FROM employees
WHERE EXTRACT(MONTH FROM birthday) = 01;
//----------------------------------------------------------------------

--Групування
--порахувати середнью заробітну плату для кожного гендера
SELECT gender, AVG(salary)
FROM employees
GROUP BY gender;


--порахувати кількість імен користувачів
SELECT first_name, count(id)
FROM users
GROUP BY first_name;

-- отримати cередню заробітну плату по людям до пенсійного віку
SELECT gender, AVG(salary)
FROM employees
WHERE EXTRACT(YEAR FROM AGE(birthday)) < 65
GROUP BY gender;

--вивести співробітників, народжених кожного місяця, з явновказаним email 
SELECT EXTRACT(MONTH FROM birthday), count(id)
FROM employees
WHERE email IS NOT NULL
GROUP BY EXTRACT(MONTH FROM birthday)
ORDER BY EXTRACT(MONTH FROM birthday);
//---------------------------------------------------------------------------

-- Умова на групу
--порахувати середнью заробітну плату для кожного гендера 
--у кого заробітна плата більше 14000
SELECT gender, AVG(salary)
FROM employees
GROUP BY gender
HAVING AVG (salary)>14000;


-- вивести гендери і мінімальні заробітні плати тільки для тих гендерів
-- чисельність яких більше 1 людини
SELECT gender, MIN(salary)
FROM employees
GROUP BY gender
HAVING count(*)>1;


-- вивести середню заробітну плату тільки для чоловіків
--1
SELECT gender, MIN(salary)
FROM employees
WHERE gender = 'male'
GROUP BY gender;

--2
SELECT gender, MIN(salary)
FROM employees
GROUP BY gender
HAVING gender = 'male';