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



-- 2 Вирази підзапитів ------------------------------------------
-- вираз IN (підзапит) -- на відповідність до одного зі списку
-- EXISTS (підзапит) => true/false
-- вираз ANY/SOME (підзапит) порівняння хоч з одним має задовольнятися
-- вираз ALL (підзапит) порівняння з усіма має задовольнятися 



-- IN --------------

-- Ex: Відобразити телефони, зроблені в ті ж роки, що і iPhone 7 або 8
SELECT *
FROM phones
WHERE manufactured_year IN (SELECT manufactured_year
                            FROM phones
                            WHERE brand = 'IPhone' AND model IN ('7', '8') );

-- Task: Відобразити телефони, які коштують стільки ж,
-- як і блакитні самсунги  
SELECT *
FROM phones
WHERE price IN (SELECT price
             FROM phones
             WHERE brand = 'Samsung' AND color = 'blue') ;  


--1Ex: Визначити, які клієнти робили замовлення  
SELECT id, first_name, last_name, email, tel
FROM users
WHERE id IN (SELECT user_id
            FROM orders);   

--2Ex: Визначити, які клієнти робили замовлення 
SELECT DISTINCT u.id, first_name, last_name, email, tel
FROM users AS u INNER JOIN orders AS o ON u.id = o.user_id ;    

-- EXISTS (підзапит) => true/false
--3Ex: Визначити, які клієнти робили замовлення 
SELECT id, first_name, last_name, email, tel
FROM users
WHERE EXISTS (
          SELECT *
          FROM orders
          WHERE users.id = orders.user_id
          );

-- EXISTS (підзапит) => true/false
-- 1Task: Відобразити інфо про телефони, які купували
SELECT *
FROM phones
WHERE EXISTS (SELECT 1
             FROM phones_to_orderes
              WHERE phones.id = phones_to_orderes.phone_id);

-- 2Task: Відобразити інфо про телефони, які купували
SELECT DISTINCT p.id,brand,model
FROM phones AS p INNER JOIN phones_to_orderes AS pto ON p.id = pto.phone_id;



-- 1Task: Відобразити інфо про телефони, які НЕ купували
SELECT *
FROM phones
WHERE NOT EXISTS (SELECT 1
             FROM phones_to_orderes
              WHERE phones.id = phones_to_orderes.phone_id);


-- 2Task: Відобразити інфо про телефони, які НЕ купували
SELECT *
FROM phones AS p LEFT JOIN phones_to_orderes AS pto ON p.id = pto.phone_id
WHERE pto.id IS NULL;




-- ALL/SOME(ANY) --------------------------------------


-- SELECT *
-- FROM phones
-- WHERE price > ALL (200,500,1000); -- більше кожного

-- SELECT *
-- FROM phones
-- WHERE price > MAX (200,500,1000); -- більше кожного


-- SELECT *
-- FROM phones
-- WHERE price > ANY (200,500,1000); -- більше хочаб одного 

-- SELECT *
-- FROM phones
-- WHERE price > min (200,500,1000); -- більше хочаб одного 


--1Відобразити телефони, які дорожче за всі Samsung
SELECT *
FROM phones
WHERE price > ALL(SELECT price
                 FROM phones
                 WHERE brand = 'Samsung');

--2Відобразити телефони, які дорожче за всі Samsung
SELECT *
FROM phones
WHERE price > (SELECT MAX (price)
                 FROM phones
                 WHERE brand = 'Samsung');


-- 1Ex: Відібрати тел, які дорожчі за хоч одного самсунгів  
SELECT *
FROM phones
WHERE price > ANY (SELECT price
                 FROM phones
                 WHERE brand = 'Samsung');    

-- 2Ex: Відібрати тел, які дорожчі за хоч одного самсунгів  
SELECT *
FROM phones
WHERE price > (SELECT MIN (price)
                 FROM phones
                 WHERE brand = 'Samsung'); 



-- Task: Відобразити інформацію про телефони, які дорожчі за кожного білих IPhone
SELECT *
FROM phones
WHERE price > ALL (SELECT price
                  FROM phones
                    WHERE brand = 'IPhone' AND color = 'white');

SELECT *
FROM phones
WHERE price > (SELECT MAX (price)
                  FROM phones
                    WHERE brand = 'IPhone' AND color = 'white');


-- Task: *Відібрати телефони з такою самою ціною, як купував Petro1     
SELECT *
FROM phones
WHERE price IN (SELECT price
              FROM users AS u INNER JOIN orders AS o ON u.id = o.id
                  INNER JOIN phones_to_orderes AS pto ON o.id = pto.order_id 
                   INNER JOIN phones AS p ON p.id = pto.phone_id
              WHERE first_name = 'Petro2');                

-- Task: *Відібрати телефони з такою самою ціною, як купував Petro1     
SELECT *
FROM phones
WHERE price IN (SELECT price
              FROM users_to_phones   -- через view(в SQL7)
              WHERE first_name = 'Petro2');               

-- Ex: *Відобразити покупки користувачів білих Samsung
-- (отримати телефони з такими самими покупцями, як покупці білих самсунгів)
SELECT *
FROM users_to_phones   -- через view(в SQL7)
WHERE u_id IN (SELECT u_id
             FROM users_to_phones
             WHERE brand = 'Samsung' AND color = 'white');               