CREATE DATABASE sushi_delivery;


CREATE TABLE sushi (
  id SERIAL PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  composition VARCHAR(100) NOT NULL,
  weight INTEGER NOT NULL CHECK (weight > 100),
  price DECIMAL CHECK (price > 0)
);


INSERT INTO sushi (title, composition, weight, price) 
VALUES
('California Roll', 'Crab, Avocado, Cucumber', 200, 8.50),
('Tuna Sashimi', 'Fresh Tuna', 150, 12.00),
('Salmon Nigiri', 'Fresh Salmon', 150, 10.00),
('Ebi Maki', 'Shrimp, Rice, Seaweed', 180, 9.00),
('Vegetable Roll', 'Cucumber, Avocado, Carrot', 120, 6.00),
('Spicy Tuna Roll', 'Spicy Tuna, Cucumber', 220, 11.00),
('Dragon Roll', 'Shrimp Tempura, Avocado, Eel', 250, 15.00),
('Rainbow Roll', 'Crab, Tuna, Salmon, Avocado', 230, 14.00),
('Tempura Roll', 'Tempura Shrimp, Avocado, Cucumber', 190, 12.50),
('Philadelphia Roll', 'Salmon, Cream Cheese, Avocado', 210, 13.00);


CREATE TABLE clients (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(64) NOT NULL,
  last_name VARCHAR(64) NOT NULL,
  email VARCHAR(64) CHECK (email <> ''),
  tel CHAR(13) NOT NULL UNIQUE CHECK (tel LIKE '+%')
);


INSERT INTO clients (first_name, last_name, email, tel) VALUES
('Ivan', 'Petrenko', 'ivan.petrenko@example.com', '+380631234567'),
('Oksana', 'Sidorova', 'oksana.sidorova@example.com', '+380631234568'),
('Andriy', 'Kovalenko', 'andriy.kovalenko@example.com', '+380631234569'),
('Olena', 'Moroz', 'olena.moroz@example.com', '+380631234570'),
('Mykola', 'Tkachenko', 'mykola.tkachenko@example.com', '+380631234571');



CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    delivery_address VARCHAR(200) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('pending', 'delivered')) NOT NULL,
    paid BOOLEAN,
    payment_method VARCHAR(20),
    total_price DECIMAL(10,2),
    delivery_time TIMESTAMP,
    client_id INTEGER NOT NULL REFERENCES clients(id)
            ON UPDATE CASCADE
            ON DELETE RESTRICT,
    total_sushi_quantity INTEGER DEFAULT 0, 
    total_pizza_quantity INTEGER DEFAULT 0  
);


INSERT INTO orders (delivery_address, status, paid, payment_method, total_price, delivery_time, client_id, total_sushi_quantity, total_pizza_quantity) 
VALUES 
('123 Main St, Kyiv', 'pending', true, 'credit_card', 50.00, '2024-10-10 12:30:00', 1, 5, 2),
('456 Elm St, Kyiv', 'delivered', false, 'cash', 75.00, '2024-10-09 15:45:00', 2, 0, 3),
('789 Oak St, Lviv', 'pending', true, 'paypal', 30.50, '2024-10-11 11:00:00', 3, 2, 1),
('321 Maple Ave, Odesa', 'delivered', true, 'credit_card', 120.00, '2024-10-08 14:15:00', 4, 4, 5),
('654 Pine Rd, Kharkiv', 'pending', false, 'cash', 40.00, '2024-10-10 13:00:00', 5, 1, 0),
('987 Birch Ln, Dnipro', 'delivered', true, 'paypal', 95.00, '2024-10-09 17:30:00', 1, 3, 2),
('135 Cedar St, Kyiv', 'pending', true, 'credit_card', 60.00, '2024-10-12 10:00:00', 2, 6, 0),
('246 Spruce Ave, Lviv', 'delivered', false, 'cash', 80.00, '2024-10-11 19:00:00', 3, 0, 4),
('369 Willow St, Odesa', 'pending', true, 'paypal', 55.50, '2024-10-12 16:45:00', 4, 2, 3),
('852 Fir Rd, Kharkiv', 'delivered', true, 'credit_card', 90.00, '2024-10-08 18:00:00', 5, 4, 1);



CREATE TABLE sushi_orders (
  id SERIAL PRIMARY KEY,
  sushi_id INTEGER NOT NULL REFERENCES sushi(id)
           ON UPDATE CASCADE
           ON DELETE RESTRICT,
  orders_id INTEGER NOT NULL REFERENCES orders(id)
           ON UPDATE CASCADE
           ON DELETE RESTRICT,     
  quantity SMALLINT NOT NULL CHECK (quantity >= 1)             
);

INSERT INTO sushi_orders (sushi_id, order_id, quantity)
VALUES
    (4, 1, 2),
    (5, 1, 1),
    (6, 2, 3),
    (7, 3, 2),
    (8, 4, 1),
    (9, 5, 3),
    (10, 6, 2),
    (11, 7, 1),
    (12, 8, 3),
    (13, 9, 2);


CREATE TABLE pizza (
  id SERIAL PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  size VARCHAR(10) CHECK (size IN ('small', 'medium', 'large')),
  composition VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) CHECK (price > 0)
);

INSERT INTO pizza (title, size, composition, price) VALUES
    ('Margherita', 'medium', 'Tomato sauce, Mozzarella cheese, Fresh basil', 8.50),
    ('Pepperoni', 'large', 'Tomato sauce, Mozzarella cheese, Pepperoni', 10.00),
    ('Hawaiian', 'medium', 'Tomato sauce, Mozzarella cheese, Ham, Pineapple', 9.00),
    ('BBQ Chicken', 'large', 'BBQ sauce, Grilled chicken, Red onions, Cilantro', 11.00),
    ('Veggie', 'small', 'Tomato sauce, Mozzarella cheese, Bell peppers, Onions, Mushrooms', 7.00),
    ('Meat Lovers', 'large', 'Tomato sauce, Mozzarella cheese, Pepperoni, Sausage, Ham, Bacon', 12.50),
    ('Four Cheese', 'medium', 'Mozzarella, Cheddar, Parmesan, Gorgonzola', 10.50),
    ('Pesto Chicken', 'medium', 'Pesto sauce, Grilled chicken, Mozzarella cheese, Sun-dried tomatoes', 11.50),
    ('Buffalo Chicken', 'large', 'Buffalo sauce, Grilled chicken, Mozzarella cheese, Blue cheese', 12.00),
    ('Mediterranean', 'small', 'Tomato sauce, Mozzarella cheese, Feta cheese, Olives, Spinach', 9.50);




CREATE TABLE pizza_orders (
  id SERIAL PRIMARY KEY,
  pizza_id INTEGER NOT NULL REFERENCES pizza(id)
           ON UPDATE CASCADE
           ON DELETE RESTRICT,
  order_id INTEGER NOT NULL REFERENCES orders(id)
           ON UPDATE CASCADE
           ON DELETE RESTRICT,     
  quantity SMALLINT NOT NULL CHECK (quantity >= 1)             
);


INSERT INTO pizza_orders (pizza_id, order_id, quantity) VALUES
    (1, 1, 1),
    (2, 1, 2), 
    (3, 2, 1), 
    (4, 2, 1),  
    (5, 3, 3),  
    (6, 4, 1),  
    (7, 5, 2),  
    (8, 6, 1),  
    (9, 7, 1), 
    (10, 8, 2); 



-------------------------
-------ЗАПИТИ------------
-------------------------

-- Вдобразити склад та вартість (певного) замовлення
SELECT o.id AS order_id,
       c.first_name,
       c.last_name,
       o.total_price,
       ARRAY_AGG(DISTINCT s.title || ' (x' || so.quantity || ')') AS sushi_items,
       ARRAY_AGG(DISTINCT p.title || ' (x' || po.quantity || ')') AS pizza_items
FROM orders AS o
JOIN clients AS c ON o.client_id = c.id
LEFT JOIN sushi_orders AS so ON o.id = so.order_id
LEFT JOIN sushi AS s ON so.sushi_id = s.id
LEFT JOIN pizza_orders AS po ON o.id = po.order_id
LEFT JOIN pizza AS p ON po.pizza_id = p.id
WHERE o.id =   1
GROUP BY o.id, c.first_name, c.last_name, o.total_price;

---- перелік замовлень на сьогодні



SELECT o.id AS order_id,
       c.first_name,
       c.last_name,
       o.created_at,
       o.total_price
FROM orders AS o
JOIN clients AS c ON o.client_id = c.id
WHERE DATE(o.created_at) = '2024-10-09';


---- перелік замовлень за певний тиждень

INSERT INTO orders (created_at, delivery_address, status, paid, payment_method, total_price, delivery_time, client_id, total_sushi_quantity, total_pizza_quantity) 
VALUES 
('2024-10-02 14:30:00', '123 Main St, Kyiv', 'pending', TRUE, 'credit_card', 35.50, '2024-10-02 15:00:00', 1, 3, 2),
('2024-10-03 17:45:00', '456 Second St, Lviv', 'delivered', TRUE, 'cash', 28.75, '2024-10-03 18:15:00', 2, 0, 4),
('2024-10-05 12:00:00', '789 Third St, Odesa', 'pending', FALSE, 'paypal', 22.00, '2024-10-05 12:30:00', 3, 1, 1),
('2024-10-07 19:15:00', '101 Fourth St, Kharkiv', 'delivered', TRUE, 'credit_card', 40.00, '2024-10-07 19:45:00', 4, 2, 3),
('2024-10-09 10:30:00', '202 Fifth St, Dnipro', 'pending', TRUE, 'cash', 15.25, '2024-10-09 11:00:00', 5, 0, 1);


SELECT o.id AS order_id,
       c.first_name,
       c.last_name,
       o.created_at,
       o.total_price
FROM orders AS o
JOIN clients AS c ON o.client_id = c.id
WHERE o.created_at BETWEEN '2024-10-02' AND '2024-10-09';

--- виручку за день

SELECT SUM(total_price) AS daily_revenue
FROM orders
WHERE DATE(created_at) = '2024-10-09';

--- виручку за місяць (сума всіх замовлень за місяць)

SELECT SUM(o.total_price) AS total_revenue
FROM orders AS o
WHERE o.created_at::DATE >= DATE_TRUNC('month', CURRENT_DATE)
AND o.created_at::DATE < (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month');

--- список клієнтів, які обслуговувалися цього місяця

SELECT DISTINCT c.id, c.first_name, c.last_name, c.email, c.tel
FROM orders AS o
JOIN clients AS c ON o.client_id = c.id
WHERE DATE_TRUNC('month', o.created_at) = DATE_TRUNC('month', CURRENT_DATE);

--- топ 5 страв на місяць

SELECT title, SUM(total_quantity) AS total_quantity
FROM (

    SELECT s.title, so.quantity AS total_quantity
    FROM sushi_orders AS so
    JOIN orders AS o ON so.order_id = o.id
    JOIN sushi AS s ON so.sushi_id = s.id
    WHERE DATE_TRUNC('month', o.created_at) = DATE_TRUNC('month', CURRENT_DATE)

    UNION ALL

    SELECT p.title, po.quantity AS total_quantity
    FROM pizza_orders AS po
    JOIN orders AS o ON po.order_id = o.id
    JOIN pizza AS p ON po.pizza_id = p.id
    WHERE DATE_TRUNC('month', o.created_at) = DATE_TRUNC('month', CURRENT_DATE)
) AS combined_orders
GROUP BY title
ORDER BY total_quantity DESC
LIMIT 5;


--- Ваш прибуток від продажу за місяць, за умови, що Ваш застосунок отримує 3% від суми замовлення

SELECT SUM(o.total_price) * 0.03 AS app_income
FROM orders AS o
WHERE o.created_at::DATE >= DATE_TRUNC('month', CURRENT_DATE)
AND o.created_at::DATE < (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month');
