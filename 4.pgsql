-- Предметна область (ПО) ПРОДАЖ ТЕЛЕФОНІВ:
   -- Користувачі можуть оформляти замовлення для покупки телефонів.
   -- Один користувач може оформляти декілька замовлень.
   -- В одному замовленні може бути кілька позицій телефонів у заданій кількості.

-- 1
--    users
--    orders
--    phones

--    users 1:m orders
--    orders n:m phones

-- Типи зв'язків між сутностями (таблицями):
-- stud 1 : 1 group_head
-- 1:1 one-to-one
    -- зустрічається рідше за інших
    -- => додаємо зовнішній ключ (REFERENCES) до однієї з табл. на іншу

-- CUSTOMER  1 : n ORDERS
-- brand 1 : n model
-- 1:n one-to-many
       -- (parent) головна 1:n залежна/дочірня (child)
       -- => додаємо зовнішній ключ (REFERENCES) до залежної табл. на головну

-- PHONES m : n ORDERS
-- stud m : n section
-- m:n many-to-many
       -- => вводимо дод. табл., яка посилатиметься (REFERENCES) на обидві з відношення m:n

--------------------------
-- 2 Схеми відношень:
-- users(id, fn, ln, email, ...); +
-- orders(id, date, delivery_address, status, user_id);
-- phones(id, brand, model, color, ...) +
-- phones_to_orders(id, order_id, phone_id, quantity)

-- 3:
--    id->model, model->brand (табличка або перерахування)
--    phones(id, model, brand_id, color, ...) m:1 brands(id, brand)

---------------------------------------------------
-- 4:
-- Спочатку створюються головні таблиці, потім залежні
-- Видаляються в зворотньому порядку

DROP DATABASE phones_sales;
CREATE DATABASE phones_sales;

-- Створення таблиці
CREATE TABLE phones (
    id SERIAL PRIMARY KEY,                      -- Унікальний ідентифікатор телефону
    brand VARCHAR(50) NOT NULL,                 -- Бренд (наприклад, Apple, Samsung)
    model VARCHAR(100) NOT NULL,                -- Модель телефону
    os VARCHAR(50) NOT NULL,                    -- Операційна система (наприклад, Android, iOS)
    screen_size FLOAT NOT NULL,                 -- Розмір екрана в дюймах (наприклад, 6.5)
    ram INTEGER NOT NULL,                       -- Оперативна пам'ять (в ГБ)
    storage_capacity INTEGER NOT NULL,          -- Обсяг пам'яті (в ГБ)
    battery_capacity INTEGER NOT NULL,          -- Ємність батареї (в мАг)
    camera_megapixels FLOAT,                    -- Кількість мегапікселів у камері (наприклад, 12.5)
    price DECIMAL(10,2),                        -- Ціна телефону
    release_date DATE,                          -- Дата виходу на ринок
    color VARCHAR(30),                          -- Колір телефону
    is_dual_sim BOOLEAN DEFAULT FALSE           -- Наявність підтримки Dual SIM
);

INSERT INTO phones (brand, model, os, screen_size, ram, storage_capacity, battery_capacity, camera_megapixels, price, release_date, color, is_dual_sim)
VALUES
    ('Apple', 'iPhone 14', 'iOS', 6.1, 6, 128, 3200, 12.0, NULL, '2022-09-16', 'Silver', FALSE),
    ('Samsung', 'Galaxy S23', 'Android', 6.8, 8, 256, 4000, 50.0, 1099.99, '2023-02-17', 'Black', TRUE),
    ('Google', 'Pixel 7 Pro', 'Android', 6.7, 12, 256, 5000, 48.0, 899.99, '2022-10-06', 'White', TRUE),
    ('Xiaomi', 'Mi 11 Ultra', 'Android', 6.81, 12, 512, 5000, 50.3, 799.99, '2021-04-02', 'Ceramic Black', TRUE),
    ('Huawei', 'P50 Pro', 'Android', 6.6, 8, 256, 4360, 50.0, 999.99, '2021-07-29', 'Gold', TRUE),
    ('OnePlus', '10 Pro', 'Android', 6.7, 12, 256, 5000, 48.0, 799.99, '2022-01-11', 'Green', TRUE),
    ('Sony', 'Xperia 1 IV', 'Android', 6.5, 12, 512, 4500, 12.0, 1299.99, '2022-06-11', 'Purple', FALSE),
    ('Nokia', 'G50', 'Android', 6.82, 4, 128, 4850, 48.0, 299.99, '2021-09-22', 'Blue', TRUE),
    ('Motorola', 'Edge 30 Ultra', 'Android', 6.67, 12, 512, 4610, 200.0, 899.99, '2022-09-10', 'Stardust White', TRUE),
    ('Oppo', 'Find X5 Pro', 'Android', 6.7, 12, 256, 5000, 50.0, 1099.99, '2022-03-14', 'Black', TRUE),
    ('Apple', 'iPhone SE 2022', 'iOS', 4.7, 4, 64, 1821, 12.0, 429.99, '2022-03-18', 'Red', FALSE),
    ('Samsung', 'Galaxy Z Flip4', 'Android', 6.7, 8, 256, 3700, 12.0, NULL, '2022-08-10', 'Blue', TRUE),
    ('Google', 'Pixel 6a', 'Android', 6.1, 6, 128, 4410, 12.2, 449.99, '2022-07-21', 'Chalk', FALSE),
    ('Xiaomi', 'Redmi Note 11', 'Android', 6.43, 6, 128, 5000, 50.0, 299.99, '2022-01-26', 'Graphite Gray', TRUE),
    ('Huawei', 'Mate 40 Pro', 'Android', 6.76, 8, 256, 4400, 50.0, 1199.99, '2020-10-22', 'Mystic Silver', TRUE),
    ('OnePlus', 'Nord 2T', 'Android', 6.43, 8, 128, 4500, 50.0, 399.99, '2022-05-19', 'Gray Shadow', TRUE),
    ('Sony', 'Xperia 5 III', 'Android', 6.1, 8, 128, 4500, 12.0, NULL, '2021-08-11', 'Black', FALSE),
    ('Nokia', 'X20', 'Android', 6.67, 8, 128, 4470, 64.0, 399.99, '2021-05-06', 'Midnight Sun', TRUE),
    ('Motorola', 'Moto G200', 'Android', 6.8, 8, 128, 5000, 108.0, 499.99, '2021-11-18', 'Stellar Blue', TRUE),
    ('Oppo', 'Reno 7 Pro', 'Android', 6.55, 12, 256, 4500, 50.0, 749.99, '2021-12-03', 'Startrails Blue', TRUE);

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(64) NOT NULL,
  last_name VARCHAR(64) NOT NULL,
  email VARCHAR(64) CHECK (email <> ''),
  tel CHAR(13) NOT NULL UNIQUE CHECK (tel LIKE '+%')
);

INSERT INTO users (first_name, last_name, email, tel) 
VALUES
    ('John', 'Doe', 'test1@mail', '+380671234567'),
    ('Jane', 'Smith', 'test2@mail', '+380959876543'),
    ('Michael', 'Johnson', 'test3@mail', '+380665554433'),
    ('Emily', 'Davis', 'test4@mail', '+380977766554'),
    ('William', 'Brown', 'test5@mail', '+380633219876');


INSERT INTO users (first_name, last_name, email, tel) 
VALUES
    ('Test', 'Testovych', 'test7@mail', '+380673333333'),
    ('Nick', 'Nickovych', 'test8@mail', '+380959595995');

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP CHECK (created_at <= CURRENT_TIMESTAMP)
               NOT NULL DEFAULT CURRENT_TIMESTAMP,
    delivery_address VARCHAR(200) NOT NULL, 
    status VARCHAR(20) CHECK (status IN ('pending', 'delivered')) NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users(id) 
            ON UPDATE CASCADE
            ON DELETE RESTRICT
);

INSERT INTO orders (delivery_address, status, user_id)
VALUES
    ('вул. Соборна, 12, Запоріжжя', 'pending', 1),
    ('пр. Металургів, 15, Запоріжжя', 'delivered', 2),
    ('вул. Бурлацька, 20, Запоріжжя', 'pending', 3),
    ('вул. Космонавтів, 25, Запоріжжя', 'delivered', 4),
    ('пр. Леніна, 30, Запоріжжя', 'pending', 5),
    ('вул. Шевченка, 35, Запоріжжя', 'delivered', 1),
    ('пр. Перемоги, 40, Запоріжжя', 'pending', 2),
    ('вул. Залізнична, 45, Запоріжжя', 'delivered', 3),
    ('пр. Маяковського, 50, Запоріжжя', 'pending', 4),
    ('вул. Пушкіна, 55, Запоріжжя', 'delivered', 5);

CREATE TABLE phones_to_orders (
  id SERIAL PRIMARY KEY,
  phone_id INTEGER NOT NULL REFERENCES phones(id)
           ON UPDATE CASCADE
           ON DELETE RESTRICT,
  order_id INTEGER NOT NULL REFERENCES orders(id)
           ON UPDATE CASCADE
           ON DELETE RESTRICT,     
  quantity SMALLINT NOT NULL CHECK (quantity >= 1)             
);

-- order 4515645151
-- ph   quantity
-- 10      1
-- 5       2

INSERT INTO phones_to_orders(order_id, phone_id, quantity) 
VALUES 
    (1, 10, 1),
    (1, 5, 2),
    (2, 1, 2),
    (3, 1, 1),
    (3, 2, 1),
    (3, 3, 1),
    (4, 4, 3),
    (5, 5, 1),
    (5, 6, 1),
    (5, 7, 2);

-- [{p_id:10, q:1}, {p_id:5, q:2}]

-- Ex: Вивести інформацію про користувачів і їх замовлення (без телефонів)
SELECT *
FROM users AS u INNER JOIN orders AS o ON u.id = o.user_id
ORDER BY u.id;

-- Вивести інфо твльки про виконані замовлення із зазначенням користувача

SELECT *
FROM users AS u INNER JOIN orders AS o ON u.id = o.user_id
WHERE status = 'delivered'
ORDER BY u.id;


-- Task: Вивести інфо про телефони і в якій кількості їх купували

   SELECT p.model,
          p_to_o.quantity
     FROM phones p
    INNER JOIN phones_to_orders p_to_o ON p.id = p_to_o.id;

-- Task: Вивести інфо про всі в телефони і, якщо їх купували, то в якій кількості 
SELECT *
FROM phones p
     LEFT JOIN phones_to_orders p_to_o ON p.id = p_to_o.phone_id
ORDER BY p.id;

SELECT p.id, p.model, sum(pto.quantity)
FROM phones p INNER JOIN phones_to_orders pto ON p.id = pto.phone_id
GROUP BY p.id, p.model
ORDER BY sum(pto.quantity);


-- Task: Вивести кількість замовлень кожного користувача

SELECT u.id, u.first_name, u.last_name, sum(u.id) orders_count
FROM users u INNER JOIN phones_to_orders pto ON u.id = pto.id
GROUP BY u.id, u.last_name, u.first_name
ORDER BY sum(u.id) DESC;


SELECT u.first_name, u.last_name, COALESCE(COUNT(o.id), 0) AS order_count
FROM users u
     LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.first_name, u.last_name
ORDER BY order_count DESC;

-- Ex.: Вивести інформацію про сумарну вартість проданих телефонів
-- кожної моделі (впорядкувати)

-- 1000*2 + 1000*3 price*quantity

SELECT p.brand, p.model, sum(p.price*p_to_o.quantity)
FROM phones AS p INNER JOIN phones_to_orders AS p_to_o
     ON p.id = p_to_o.phone_id
GROUP BY p.id;

-- Відобразити який користувач який телефон купив
P P  IPhone X
P P  Huawei P30
T SH Huawei P30

SELECT u.first_name || ' ' || u.last_name AS customer,
       p.brand || ' ' || p.model AS phone
FROM users AS u 
    INNER JOIN orders AS o ON u.id = o.user_id
    INNER JOIN phones_to_orders AS p_to_o ON o.id = p_to_o.order_id
    INNER JOIN phones AS p ON p_to_o.phone_id = p.id;

-- Які телефони купував Michael Johnson   
SELECT u.first_name || ' ' || u.last_name AS customer,
       p.brand || ' ' || p.model AS phone
FROM users AS u 
    INNER JOIN orders AS o ON u.id = o.user_id
    INNER JOIN phones_to_orders AS p_to_o ON o.id = p_to_o.order_id
    INNER JOIN phones AS p ON p_to_o.phone_id = p.id
WHERE u.first_name = 'Michael' AND u.last_name = 'Johnson';

-- Скільки телефонів купив кожен користувач
SELECT u.first_name || ' ' || u.last_name AS customer, sum(p_to_o.quantity)
FROM users AS u 
    INNER JOIN orders AS o ON u.id = o.user_id
    INNER JOIN phones_to_orders AS p_to_o ON o.id = p_to_o.order_id 
GROUP BY u.id;

-- Відобразити користувачів, які купили більше 2 тел.
SELECT u.first_name || ' ' || u.last_name AS customer, sum(p_to_o.quantity)
FROM users AS u 
    INNER JOIN orders AS o ON u.id = o.user_id
    INNER JOIN phones_to_orders AS p_to_o ON o.id = p_to_o.order_id 
GROUP BY u.id
HAVING sum(p_to_o.quantity) > 2;


CREATE VIEW users_phones AS
SELECT p.*, u.first_name, u.last_name, u.email, u.tel, 
       o.created_at, o.delivery_address, o.status, o.user_id, 
       ptoo.order_id, ptoo.quantity
FROM users AS u INNER JOIN orders AS o ON u.id = o.user_id
     INNER JOIN phones_to_orders AS ptoo ON o.id = ptoo.order_id
     INNER JOIN phones AS p ON ptoo.phone_id = p.id;


SELECT *
FROM users_phones;


-- Скільки телефонів купив кожен користувач
SELECT first_name || ' ' || last_name AS customer,
       brand || ' ' || model AS phone
FROM users_phones
WHERE first_name = 'Michael' AND last_name = 'Johnson';


-- Обчислити кількість замовлень кожного користувача



CREATE VIEW quantity_of_orders AS
SELECT u.first_name, u.last_name, u.email, u.tel, 
       o.created_at, o.delivery_address, o.status, o.user_id   
FROM users u INNER JOIN orders o ON u.id = o.user_id

SELECT first_name, last_name, count(*) AS count
FROM quantity_of_orders
GROUP BY user_id, last_name, first_name
ORDER BY count DESC;

-----------------------------------------------
-----------------------------------------------


-- Умовні вирази (9.18)
-- CASE

-- повна форма (подібна if .. else if .. else)
-- CASE WHEN умова THEN результат
-- [WHEN ...]
-- [ELSE результат]
-- END

-- коротка форма (подібна switch..case)
-- CASE вираз
-- WHEN значення THEN результат
-- [WHEN ...]
-- [ELSE результат]
-- END

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


SELECT name, 
CASE is_male  
    WHEN true THEN 'Male'
    WHEN false THEN 'Female'
    ELSE 'Other'
  END
FROM users1;


-- Task: Вивести користувачів у вигляді
-- id name  is_male
-- 1  ***ko true
-- 2  ***ky true
-- ...
-- 5  ***** false

SELECT id, 
  CASE WHEN name LIKE '%ko' THEN '***ko'
       WHEN name LIKE '%ky' THEN '***ky'
       ELSE '*****' 
  END,
  is_male
FROM users1;


-- Ex: Знайти тел, дорожчі за 	Motorola	Edge 30 Ultra

SELECT *
FROM phones
WHERE price > (

    SELECT price
    FROM phones
    WHERE brand = 'Motorola' AND model = 'Edge 30 Ultra');


-- Ex: Відобразити список телефонів дорожче за середній за ціною 

SELECT *
FROM phones
WHERE price > (
    SELECT avg(price)
    FROM phones
);

-- Task: Відобразити телефони, які коштують так само,
-- як і найдешевший телефон

SELECT *
FROM phones
WHERE price = (
    SELECT min(price)
    FROM phones
);

-- Task: Відібрати телефони, які зроблені того ж року, 
-- що і Samsung  Galaxy Z Flip4

SELECT *
FROM phones
WHERE EXTRACT (YEAR from release_date) = (
    SELECT EXTRACT (YEAR from release_date)
    FROM phones
    WHERE brand = 'Samsung' AND model ='Galaxy Z Flip4'
);

-- Ex: *Відобразити інформацію про телефони, які старіші за найдорожчий Google


SELECT *
FROM phones
WHERE release_date < (
    SELECT release_date
    FROM phones
    WHERE brand = 'Google' AND price = (
        SELECT MAX(price)
        FROM phones
        WHERE brand = 'Google')
);


-- Відобразити всі замовлення (основна інфа) Jane Smith
SELECT *
FROM orders
WHERE user_id = (
    SELECT id
    FROM users
    WHERE first_name='Jane' AND last_name='Smith'
);


-- корельовані підзапити (якщо можна уникнути, то уникати, 
-- оскільки виконуються по 1 разу для кожного рідка зовнішнього запиту)
-- звичайний підзапит виконується 1 раз

SELECT *, 
    (SELECT first_name FROM users AS u WHERE u.id = o.user_id) AS name,
    (SELECT last_name FROM users AS u WHERE u.id = o.user_id) AS surname
FROM orders AS o
WHERE o.user_id = (
    SELECT id
    FROM users
    WHERE first_name='Jane' AND last_name='Smith'
);

SELECT o.*, first_name || ' ' || last_name AS fullname
FROM orders o INNER JOIN users u ON o.user_id=u.id
WHERE o.user_id = (
    SELECT id
    FROM users
    WHERE first_name='Jane' AND last_name='Smith'
);


-- 2 Вирази підзапитів (9.23)
-- вираз IN (підзапит) -- на відповідність до одного зі списку
-- EXISTS (підзапит) => true/false
-- вираз ANY/SOME (підзапит) порівняння хоч з одним має задовольнятися
-- вираз ALL (підзапит) порівняння з усіма має задовольнятися
--- IN -------------------------------------------------
-- Знайти телефони з такими ж батареями, як і у Моторол

SELECT *
FROM phones
WHERE battery_capacity IN (
    SELECT battery_capacity
    FROM phones
    WHERE brand = 'Motorola');


-- Знайти телефони, виготовлені в ті ж роки, що і наявні мотороли

SELECT *
FROM phones
WHERE EXTRACT(YEAR FROM release_date) IN (
    SELECT EXTRACT(YEAR FROM release_date)
    FROM phones
    WHERE brand = 'Motorola'
);

-- Ex.: Відобразити інфо про телефони, які купували

SELECT * 
FROM phones
WHERE id IN (
    SELECT phone_id 
    FROM phones_to_orders
);

-- =
SELECT DISTINCT p.id, brand, model
FROM phones p INNER JOIN phones_to_orders ptoo ON p.id = ptoo.phone_id
ORDER BY p.id;
-- =
SELECT *
FROM phones p
WHERE EXISTS(
    SELECT 1
    FROM phones_to_orders ptoo
    WHERE p.id = ptoo.phone_id
);

-- Task: Відобразити інфо про телефони, які не купували
-- Task: Відобразити інфо про телефони, які не купували
SELECT *
FROM phones p
WHERE NOT EXISTS(
    SELECT 1
    FROM phones_to_orders ptoo
    WHERE p.id = ptoo.phone_id
);
--=
SELECT * 
FROM phones
WHERE id NOT IN (
    SELECT phone_id 
    FROM phones_to_orders
);
--=
SELECT *
FROM phones p LEFT JOIN phones_to_orders ptoo ON p.id = ptoo.phone_id
WHERE ptoo.id IS NULL;

-- Ex: Відібрати тел, які дорожчі за всіх xiaomi

SELECT *
FROM phones
WHERE price > ALL (
    SELECT price
    FROM phones
    WHERE brand = 'Xiaomi'
);


-- Task: Відібрати тел, які дешевші за хоч одного самсунгів

SELECT *
FROM phones
WHERE price < ANY (
    SELECT price
    FROM phones
    WHERE brand = 'Motorola'
);

-- ALL >max, <min
-- ANY >min, <max
SELECT *
FROM phones
WHERE price <  (
    SELECT max(price)
    FROM phones
    WHERE brand = 'Motorola'
);


-- Поєднання запитів (7.4)

-- Знайти всі фрукти з обох таблиць
SELECT *
FROM basket_a a FULL OUTER JOIN basket_b b ON a.fruit_a = b.fruit_b;
-- Apple
-- Orange
-- Banana
-- Cucumber
-- Watermelon
-- Pear

SELECT fruit_a
FROM basket_a
UNION
SELECT fruit_b
FROM basket_b;

-- Відобразити фрукти, які є і там, і там
SELECT *
FROM basket_a a INNER JOIN basket_b b ON a.fruit_a = b.fruit_b;

SELECT fruit_a
FROM basket_a
INTERSECT
SELECT fruit_b
FROM basket_b

-- Що є в а, але немає в б

SELECT fruit_a
FROM basket_a
EXCEPT
SELECT fruit_b
FROM basket_b

-- Що є в б, але немає в а

SELECT fruit_b
FROM basket_b
EXCEPT
SELECT fruit_a
FROM basket_a

-- Обрати телефони, які не купували

SELECT id
FROM phones
EXCEPT
SELECT phone_id
FROM phones_to_orders