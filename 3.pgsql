CREATE DATABASE hospital;



CREATE TABLE doctors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  middle_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  raiting FLOAT CHECK (raiting BETWEEN 1 AND 5),
  experience SMALLINT NOT NULL CHECK (experience BETWEEN 0 AND 100) DEFAULT 0
);


CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  middle_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  birthday DATE NOT NULL CHECK (birthday <= CURRENT_DATE),
  phohe_number CHAR(13),
  id_doctor INTEGER REFERENCES doctors(id)
            ON UPDATE CASCADE
            ON DELETE SET NULL
);

INSERT INTO doctors (first_name, middle_name, last_name, raiting, experience)
VALUES
  ('Іван', 'Петрович', 'Коваль', 4.8, 15),
  ('Марія', 'Іванівна', 'Сидоренко', 4.2, 8),
  ('Олег', 'Миколайович', 'Федоров', 3.9, 20);

INSERT INTO patients(first_name, middle_name, last_name, birthday, phohe_number, id_doctor)
VALUES ('Test','Testovych', 'Testovych', '2000-12-01', '+380987654321', NULL);

UPDATE doctors
SET id = 100
WHERE id = 1;

DELETE 
FROM doctors
WHERE id = 100;

INSERT INTO doctors (first_name, middle_name, last_name, raiting, experience)
VALUES
  ('Ivan', 'Petrovych', 'Kovalenko', 4.0, 1);



INSERT INTO patients (first_name, middle_name, last_name, birthday, phohe_number, id_doctor)
VALUES
  ('Петро', 'Іванович', 'Захарченко', '1985-02-15', '0951234567', 2),
  ('Оксана', 'Михайлівна', 'Ковальчук', '1990-07-28', '0968765432', 3),
  ('Андрій', 'Сергійович', 'Шевченко', '1975-11-10', '0973210987', 4),
  ('Марія', 'Олексіївна', 'Ткаченко', '1992-04-03', '0937896543', 5),
  ('Ігор', 'Васильович', 'Костенко', '1988-09-18', '0982345678', 2);


SELECT * 
FROM doctors AS d INNER JOIN patients AS p ON d.id = p.id_doctor 
ORDER BY d.id;


-- Знайти лікарів, які мають пацієнтів віком 38+ років
SELECT d.first_name, d.last_name
FROM doctors AS d INNER JOIN patients AS p ON d.id = p.id_doctor
WHERE EXTRACT(YEAR FROM age(p.birthday)) >= 38;


-- Знайти лікаря у Захарченка Петра
SELECT d.first_name, d.middle_name, d.last_name
FROM doctors as d
INNER JOIN patients ON d.id = patients.id_doctor
WHERE patients.first_name = 'Петро' AND patients.last_name = 'Захарченко';


-- LEFT JOIN
SELECT *
FROM patients AS p LEFT JOIN doctors AS d ON p.id_doctor = d.id
WHERE d.id IS NULL;


-- Знайти лікарів, які не міють пацієнтів
SELECT  *
FROM doctors d
    LEFT JOIN patients p ON d.id = p.id_doctor
WHERE p.id IS NULL;


-- Знайти всю інфо про лікарів і пацієнтів
SELECT *
FROM doctors d
    FULL OUTER JOIN patients p ON d.id = p.id_doctor
ORDER BY d.id, p.id;


CREATE DATABASE plant;

CREATE TYPE gender_type AS ENUM ('male', 'female', 'other');

CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  first_name varchar(30) NOT NULL,
  last_name varchar(30) NOT NULL,
  email varchar(50) CHECK (email <> ''),
  birthday date NOT NULL CHECK (birthday < current_date),
  gender gender_type NOT NULL,
  salary numeric(10,2) NOT NULL DEFAULT 6000.00
);



INSERT INTO employees (first_name, last_name, email, birthday, gender, salary)
VALUES
  ('John', 'Doe', 'johndoe@example.com', '1985-02-15', 'male', 65000.00),
  ('Jane', 'Smith', 'janesmith@example.com', '1990-07-28', 'female', 58000.00),
  ('Michael', 'Johnson', 'michaeljohnson@example.com', '1975-11-10', 'male', 72000.00),
  ('Emily', 'Davis', 'emilydavis@example.com', '1992-04-03', 'female', 60000.00),
  ('David', 'Wilson', 'davidwilson@example.com', '1988-09-18', 'male', 68000.00),
  ('Olivia', 'Miller', 'oliviamiller@example.com', '1995-05-22', 'female', 55000.00),
  ('Noah', 'Taylor', 'noahtaylor@example.com', '1980-08-10', 'male', 70000.00),
  ('Ava', 'Anderson', 'avaanderson@example.com', '1997-12-05', 'female', 57000.00),
  ('Liam', 'Lee', 'liamlee@example.com', '1982-03-17', 'male', 62000.00),
  ('Sophia', 'Clark', 'sophiaclark@example.com', '1999-01-29', 'female', 59000.00);


SELECT count(*) AS workers_count
FROM employees;

SELECT avg(salary) AS "Avarage salary"
FROM employees;



-- Знайти мінімальну зп
SELECT min(salary) "Min Salary"
FROM employees;


-- Обчислити середній вік працівників
SELECT avg(EXTRACT(YEAR FROM AGE(birthday))) "Average age"
FROM employees;

-- Визначити кількість співробітників, у яких ДН в січні
SELECT count(id) AS emp_count
FROM employees
WHERE EXTRACT(MONTH FROM birthday) = 1;

-- Task: Обчислити максимальну зп жінок
SELECT max(salary) "Max Female Salary"
FROM employees
WHERE gender = 'female';


-- Ex: Обчислити середню зп для кожного гендера
SELECT gender, avg(salary)
FROM employees
GROUP BY gender;

-- Обчислити кількість користувачів з кожним ім'ям
SELECT first_name, count(first_name)
FROM employees
GROUP BY first_name;

--  Вивести кількість співробітників, народжених кожного місяця, 
--       * з явно вказаними email

-- SELECT
-- FROM
-- WHERE
-- GROUP BY
-- ORDER BY
-- LIMIT OFFSET

SELECT EXTRACT(MONTH FROM birthday) AS month_number, count(id)
FROM employees
WHERE email IS NOT NULL
GROUP BY month_number
ORDER BY month_number;

-- Умова на групу (фільтрація груп) (7.2.3)
-- HAVING

-- Відобразити середню зп тих гендерів, для яких вона більше за 60000

SELECT avg(salary), gender
FROM employees
GROUP BY gender
HAVING avg(salary) > 60000;

-- Відобразити середню зп чоловіків

SELECT gender, AVG(salary) AS avg_salary
FROM employees
GROUP BY gender
HAVING gender = 'male';

SELECT avg(salary) man_avg_salary
FROM employees
WHERE gender = 'male'


-- 5 SELECT 3.5 aggregate_func
-- 1 FROM
-- 2 WHERE
-- 3 GROUP BY
       
-- 4 HAVING
-- 6 ORDER BY
-- 8 LIMIT 7 OFFSET