CREATE DATABASE phones_sales;
-- DROP DATABASE phones_sales;

-- CREATE DATABASE "PhonesSales";

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

-- DROP TABLE phone;

-- C 
INSERT INTO phones(brand, model, os, screen_size, ram, storage_capacity, battery_capacity, camera_megapixels, price, release_date, color, is_dual_sim)
VALUES ('Xiaomi', 'Mi 9', 'HyperOS', 6.6, 8, 256, 5000, 100, 300, '2022-09-06', 'Yellow', TRUE);

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

INSERT INTO phones(brand, model, os, screen_size, ram, storage_capacity, battery_capacity, camera_megapixels, price, release_date, color)
VALUES ('Xiaomi', 'Mi 10', 'HyperOS', 6.6, 8, 256, 5000, 100, 300, '2023-09-06', 'Yellow');

-- !!! Видаляє всі дані з таблиці --
DELETE 
FROM phones;

-- SELECT що
-- FROM звідки

-- * - вивести всі стовпці
SELECT *
FROM phones;

-- Проєкція - вибрати конкретні стовпці
SELECT brand, model, os, price
FROM phones;

-- Призначення псевдонімів (ім'я_стовпця/значення AS нове_ім'я)
SELECT brand, model, os, price, storage_capacity AS storage
FROM phones;

-- Використання функцій (глава 9)
SELECT brand || ' ' || model AS phone, price, EXTRACT(YEAR FROM release_date) AS year
FROM phones;

-- Вивести вік телефона
SELECT brand, model, price, EXTRACT(YEAR FROM age(release_date)) AS phohe_age
FROM phones;

-- Відображення різних значень DISTINCT (тобто прибрати рядки, що дублюються) (2.5)
SELECT DISTINCT brand
FROM phones;

-- ORDER BY
-- Сортування (2.5, 7.5)
-- ORDER BY _ ASC (за зростанням: за замовчуванням),
--            DESC (за спаданням: вказувати явно)
SELECT *
FROM phones
ORDER BY price DESC;

-- Впорядкувати за віком від найновішого до найстарішого
SELECT *
FROM phones
ORDER BY release_date DESC;

SELECT *
FROM phones
ORDER BY brand ASC, model ASC;

-- 1, 5 --
-- Пагінація (7.6)
-- LIMIT (скільки відобразити) OFFSET (скільки пропустити)

SELECT *
FROM phones
ORDER BY id
LIMIT 5;

-- 2, 5 --
SELECT *
FROM phones
ORDER BY id
LIMIT 5 OFFSET 5;
-- OFFSET = (page - 1)*LIMIT

-- by price, 3 стор. по 4 рядка
SELECT *
FROM phones 
ORDER BY price
LIMIT 4 OFFSET 8;

-- Task
-- вивести найстаріший телефон
SELECT *
FROM phones
ORDER BY release_date
LIMIT 1;

-- отримати кольори телефонів (DISTINCT)
SELECT DISTINCT color
FROM phones;

-- відобразити тільки модель, бренд і обсяги пам'яті телефонів
SELECT brand, model, storage_capacity
FROM phones;

-- відобразити модель, бренд і місяць релізу телефону
SELECT brand, model, EXTRACT(MONTH FROM release_date) AS release_month
FROM phones;


SELECT *
FROM phones
WHERE EXTRACT(YEAR FROM release_date) <>2022;


-- відібрати телефони сяомі на 512 
SELECT *
FROM phones
WHERE brand = 'Xiaomi' AND storage_capacity = 512;

-- Знайти телефони з батареєю від 5000 2023 року
SELECT *
FROM phones
WHERE battery_capacity >= 5000 AND EXTRACT (YEAR FROM release_date) = 2023;

-- Знайти телефони або з батареєю від 4500 або з екраном 6.6
SELECT *
FROM phones
WHERE battery_capacity >= 4500 OR screen_size >= 6.6;


-- grey phones
SELECT *
FROM phones
WHERE color ILIKE '%gr_y%';

-- price 
SELECT *
FROM phones
WHERE price >= 700 AND price <= 900;

-- BETWEEN

SELECT *
FROM phones
WHERE price BETWEEN 700 AND 900;


SELECT *
FROM phones
WHERE EXTRACT (YEAR FROM release_date) BETWEEN 2021 AND 2022;


SELECT *
FROM phones
WHERE price BETWEEN 500 AND 1100 AND release_date >= '2022-01-01'
ORDER BY price
LIMIT 5 ;


SELECT *
FROM phones
WHERE brand IN ('Samsung', 'Sony', 'Xiaomi');


SELECT *
FROM phones
WHERE EXTRACT(MONTH FROM release_date) IN (12, 1, 2, 6, 7, 8);


-- UPDATE phones
-- SET price = 1000;

UPDATE phones
SET price = 500
WHERE id =  13
RETURNING *;

SELECT *
FROM phones
WHERE id = 13;


UPDATE phones
SET price = price *1.1
WHERE battery_capacity >= 5000;

DELETE 
FROM phones
WHERE id = 20
RETURNING *;


