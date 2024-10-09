CREATE DATABASE all_students;


CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  birthday DATE NOT NULL,
  phone_number VARCHAR(15),
  group_code VARCHAR(10) NOT NULL,
  avg_mark DECIMAL(3, 2) CHECK (avg_mark >= 0 AND avg_mark <= 5),
  gender CHAR(1) CHECK (gender IN ('M', 'F')),
  entered_at INTEGER CHECK ( entered_at >= 2000 AND entered_at <= EXTRACT( YEAR FROM CURRENT_DATE)),
  department VARCHAR(100) NOT NULL
);


INSERT INTO students (first_name, last_name, birthday, phone_number, group_code, avg_mark, gender, entered_at, department)
VALUES
  ('Ivan', 'Bohdanuck', '2006-02-15', '+380962344323', 'CS-101', 4.5, 'M', 2020, 'Computer Science');



DELETE FROM students
WHERE first_name = 'John' AND last_name = 'Doe';


INSERT INTO students (first_name, last_name, birthday, phone_number, group_code, avg_mark, gender, entered_at, department)
VALUES
  ('Mykola', 'Shevchenko', '2001-02-15', '+380501234567', 'CS-101', 4.50, 'M', 2020, 'Computer Science'),
  ('Iryna', 'Koval', '2000-05-20', '+380671234567', 'CS-101', 3.80, 'F', 2020, 'Computer Science'),
  ('Olha', 'Melnyk', '2001-08-12', '+380931234567', 'IT-102', 4.90, 'F', 2021, 'Information Technology'),
  ('Andriy', 'Boyko', '2002-01-10', '+380631234567', 'IT-102', 4.20, 'M', 2021, 'Information Technology'),
  ('Anton', 'Antonov', '2001-11-30', '+380991234567', 'CS-101', 4.00, 'M', 2020, 'Computer Science'),
  ('Mykola', 'Tkachenko', '1999-12-25', '+380501234568', 'CS-101', 3.90, 'M', 2019, 'Computer Science'),
  ('Svitlana', 'Klymenko', '2000-09-18', '+380671234568', 'IT-102', 4.60, 'F', 2021, 'Information Technology'),
  ('Ivan', 'Bondarenko', '2002-03-22', '+380931234568', 'CS-103', 4.00, 'M', 2022, 'Computer Science'),
  ('Kateryna', 'Mazurenko', '2001-04-14', '+380631234568', 'IT-104', 5.00, 'F', 2022, 'Information Technology'),
  ('Volodymyr', 'Antonov', '2000-10-01', '+380991234568', 'CS-103', 4.30, 'M', 2022, 'Computer Science'),
  ('Oksana', 'Zhuk', '2001-07-09', '+380501234569', 'IT-104', 4.50, 'F', 2022, 'Information Technology'),
  ('Yaroslav', 'Chernenko', '2002-02-11', '+380671234569', 'CS-103', 4.70, 'M', 2022, 'Computer Science'),
  ('Tetiana', 'Havrylenko', '2000-05-17', '+380931234569', 'IT-104', 4.10, 'F', 2021, 'Information Technology'),
  ('Mykola', 'Rudenko', '1999-11-11', '+380631234569', 'CS-101', 4.90, 'M', 2020, 'Computer Science'),
  ('Viktoriya', 'Hrytsenko', '2001-01-19', '+380991234569', 'IT-102', 3.90, 'F', 2021, 'Information Technology'),
  ('Anton', 'Sytnyk', '2002-06-30', '+380501234570', 'CS-103', 4.80, 'M', 2022, 'Computer Science'),
  ('Natalia', 'Polishchuk', '2000-08-05', '+380671234570', 'IT-104', 4.00, 'F', 2022, 'Information Technology'),
  ('Mykola', 'Shulga', '1999-09-28', '+380931234570', 'CS-101', 4.60, 'M', 2020, 'Computer Science'),
  ('Vasya', 'Zhovtenko', '2001-12-12', '+380631234570', 'IT-102', 4.30, 'M', 2021, 'Information Technology'),
  ('Anastasiya', 'Fedorova', '2002-04-03', '+380991234570', 'CS-103', 4.20, 'F', 2022, 'Computer Science'),
  ('Vasia', 'Levchenko', '2001-11-15', '+380501234571', 'IT-102', 4.00, 'M', 2021, 'Information Technology'),
  ('Mariia', 'Holub', '2000-03-27', '+380671234571', 'CS-101', 4.40, 'F', 2020, 'Computer Science'),
  ('Lyudmyla', 'Dovzhenko', '2001-07-07', '+380931234571', 'IT-102', 3.80, 'F', 2021, 'Information Technology'),
  ('Vasia', 'Musiienko', '2002-09-13', '+380631234571', 'CS-103', 4.10, 'M', 2022, 'Computer Science'),
  ('Yuliya', 'Sokol', '2000-06-23', '+380991234571', 'IT-104', 4.50, 'F', 2022, 'Information Technology');





-- Отримати інформацію про студентів (ім'я+прізвище *через пробіл, дата народження) у порядку від найстаршого до наймолодшого.
SELECT first_name || ' ' || last_name AS student, birthday
FROM students
ORDER BY birthday;

-- Отримати список шифрів груп, що не повторюються.
SELECT DISTINCT group_code
FROM students;

-- Отримати рейтинговий список студентів (ім'я (*або ініціал)+прізвище, середній бал): спочатку студентів із найвищим середнім балом, наприкінці з найменшим.
SELECT last_name || ' ' || LEFT(first_name,1) AS name, avg_mark
FROM students
ORDER BY avg_mark DESC;

-- Отримати другу сторінку списку студентів під час перегляду по 6 студентів на сторінці.
SELECT *
FROM students
LIMIT 6 OFFSET 6;

--Отримати список 3-х найуспішніших студентів (ім'я, прізвище, середній бал, група).
SELECT first_name || ' ' || last_name AS name, avg_mark, group_code
FROM students
ORDER BY avg_mark DESC
LIMIT 3;

-- * Отримати інфо про студентів (ініціал+прізвище, номер телефону), де номер телефону буде частково прихований та представлений у форматі: +38012******* (тобто видно код оператора, але не сам номер). 
SELECT 
CONCAT(LEFT(first_name, 1), '. ', last_name, ', ', SUBSTRING(phone_number FROM 1 FOR 6), '****', '****')
FROM students
WHERE phone_number  SIMILAR TO '%(067|068|096|097|098)%';



--Відобразити студентів на ім'я Anton та прізвище Antonov.
SELECT * 
FROM students
WHERE first_name = 'Anton' AND last_name = 'Antonov';


--Відобразити студентів, які народилися в період із 2005 по 2008 рік.
SELECT * 
FROM students
WHERE EXTRACT (YEAR FROM birthday) BETWEEN 2005 AND 2008;

--Відобразити студентів на ім'я Mykola із середніми балами більше 4.5.
SELECT * 
FROM students
WHERE first_name = 'Mykola' AND avg_mark >= 4.5;

--*Відобразити студентів, які користуються послугами оператора Київстар. (тобто код 098 або 096 або ...)
SELECT * 
FROM students
WHERE phone_number ~ '^\+380(67|68|96|97|98)';


--Для всіх студентів з ім'ям Vasya змінити написання імені Vasia.
UPDATE students
SET first_name = 'Vasia'
WHERE first_name = 'Vasya'
RETURNING *;

SELECT *
FROM students
WHERE first_name = 'Vasia';


-- *Додати до таблиці стовпець з інформацією про номер студентського білету студента (2 букви - 5 цифр 1 буква: AA-00000A). Додати дані в цей стовпець (мінімум в один рядок).

ADD CONSTRAINT chk_student_id_card
CHECK (student_id_card ~ '^[A-Z]{2}-[0-9]{5}[A-Z]$');


WITH updated_students (id, student_id_card) AS (
    VALUES
        (1, 'AA-12345B'),
        (2, 'BB-54321A'),
        (3, 'CC-67890D'),
        (4, 'DD-23456C'),
        (5, 'EE-34567D'),
        (6, 'FF-45678E'),
        (7, 'GG-56789F'),
        (8, 'HH-67890G'),
        (9, 'II-78901H'),
        (10, 'JJ-89012I'),
        (11, 'KK-90123J'),
        (12, 'LL-01234K'),
        (13, 'MM-12345L'),
        (14, 'NN-23456M'),
        (15, 'OO-34567N'),
        (16, 'PP-45678O'),
        (17, 'QQ-56789P'),
        (18, 'RR-67890Q'),
        (19, 'SS-78901R'),
        (20, 'TT-89012S'),
        (21, 'UU-90123T'),
        (22, 'VV-01234U'),
        (23, 'WW-12345V'),
        (24, 'XX-23456W'),
        (25, 'YY-34567X'),
        (26, 'ZZ-45678Y'),
        (27, 'ZZ-45579Y')
)

UPDATE students
SET student_id_card = updated_students.student_id_card
FROM updated_students
WHERE students.id = updated_students.id;

SELECT *
FROM students;


--Видалити інформацію про студентів, що вступили 2010 року.

INSERT INTO students (first_name, last_name, birthday, phone_number, group_code, avg_mark, gender, entered_at, department)
VALUES
  ('Victor', 'Mazur', '1998-02-15', '+380962344323', 'CS-101', 4.5, 'M', 2010, 'Computer Science'); -- Додав студента з роком вступу 2010

DELETE 
FROM students
WHERE  entered_at = 2010
RETURNING *;