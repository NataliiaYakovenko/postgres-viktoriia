-- Прямий інжиніринг: ER-діаграма (сутність-зв'язок) -> схема даних
-- Зворотній інжиніринг: дані -> діаграма зв'язків

--Знайти телефони дорожчк за Айфон10
SELECT *
FROM phones
WHERE price > (SELECT price
           FROM phones
           WHERE brand = 'IPhone' AND model = 'X');

-- Відобразити списрк телефонів дорожче ніж середня ціна
SELECT *
FROM phones
WHERE price >(SELECT AVG(price)
              FROM phones); 

 -- Відобразіть телефони, які коштують так само, як і найдешевший телефон
SELECT *
FROM phones
WHERE price = (SELECT MIN(price)
              FROM phones);

--Відобразіть телефони, які вироблені того ж року, що і Samsung GALAXY          
SELECT *
FROM phones
WHERE manufactured_year = (SELECT manufactured_year
              FROM phones
              WHERE brand = 'Samsung' AND model = 'GALAXY2');


 --Відобразити інформацію про телефони, які старші за найдорожчий IPhone             
SELECT *
FROM phones
WHERE manufactured_year < (SELECT manufactured_year
                          FROM phones
                          WHERE brand = 'IPhone' AND price = (SELECT MAX(price)
                                        FROM phones
                                        WHERE brand = 'IPhone'));


