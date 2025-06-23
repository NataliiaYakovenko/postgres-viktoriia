-- Предметна область (ПО) ПРОДАЖ ТЕЛЕФОНІВ:
   -- Користувачі можуть оформляти замовлення для покупки телефонів.
   -- Один користувач може оформляти декілька замовлень.
   -- В одному замовленні може бути кілька позицій телефонів у заданій кількості.

-- Замовлення 
-- id | fn  | ln  | email  | Ntel  |  tel |  screen |  cpu |  amount | date  | orderN
-- id | fn1 | ln1 | email1 | Ntel1 | tel1 | screen1 | cpu1 |    1    | date1 | order1
-- id | fn1 | ln1 | email1 | Ntel1 | tel2 | screen2 | cpu2 |    2    | date1 | order1
-- id | fn2 | ln2 | email2 | Ntel2 | tdv1 | screen1 | cpu1 |    2    | date2 | order2

-- Але тут є НЕДОЛІКИ:
--           - дублювання даних
--           - відсутність єдиного джерела істини

-- НОРМАЛІЗУЄМО відношення (розділяємо на кілька таблиць без вказаних недоліків):

-- USERS (id, fn, ln, tel, email)
-- TELS(id, brand, model, screen, cpu)
-- ORDERS(id,   N,    date,       user_id)
--    ex: 1   123456  2023-03-01    1
-- TEL_TO_ORDERS(id, order_id, tel_id, count)
--    ex:        1     1        1       1
--    ex:        2     1        10      2

-- Отже, дані зберігаємо оптимально, а збірні дані з різних таблиць вигляду
-- 1 id, N, date, id, fn, ln, tel, email  id, brand, model, screen, cpu count
-- отримуєто запитами (наприклад, з'єднаннями, підзапитами)

-- Типи зв'язків між сутностями (таблицями):
   -- 1:1 one-to-one
       -- зустрічається рідше за інших
       -- => як правило, одна з таблиць посилається на іншу
   -- 1:n one-to-many
       -- (parent) головна 1:n залежна/дочірня (child)
       -- => додаємо зовнішній ключ (REFERENCES) до залежної табл. на головну
   -- m:n many-to-many
       -- => вводимо дод. табл., яка посилатиметься (REFERENCES) на обидві з відношення m:n

-- Для ПО ПРОДАЖ ТЕЛЕФОНІВ:
-- user 1 <-> n orders (тому в orders додали user_id )
-- tels m <-> n orders (тому додали додаткову таблицю)

-- Ex: m:n
-- stud  N :  M subject => 3 таблиці
-- 1) stud
-- 2) subject
-- 3) stud_to_subjects (id, stud_id, subj_id, mark)
     
-- Ex: brand-model-tel     
-- brand  1 : m  model  1 : n  tel, тоді:
-- 1) BRANDS(id, address)
-- 2) MODELs( id, name, ..., brand_id)
-- 3) TELs( id, SN, IMEI, model_id)