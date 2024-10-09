CREATE DATABASE university;



--  students
--  exams
-- courses
-- course_to_exams


CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  birthday DATE NOT NULL,
  phone_number VARCHAR(15),
  group_code VARCHAR(10) NOT NULL,
  gender CHAR(1) CHECK (gender IN ('M', 'F')),
  entered_at INTEGER CHECK ( entered_at >= 2000 AND entered_at <= EXTRACT( YEAR FROM CURRENT_DATE)),
  department VARCHAR(100) NOT NULL
);

INSERT INTO students (first_name, last_name, birthday, phone_number, group_code, gender, entered_at, department)
VALUES
  ('Микола', 'Шевченко', '2001-02-15', '+380501234567', 'CS-101', 'M', 2020, 'Computer Science'),
  ('Ірина', 'Коваль', '2000-05-20', '+380671234567', 'CS-101', 'F', 2020, 'Computer Science'),
  ('Ольга', 'Мельник', '2001-08-12', '+380931234567', 'IT-102', 'F', 2021, 'Information Technology'),
  ('Андрій', 'Бойко', '2002-01-10', '+380631234567', 'IT-102', 'M', 2021, 'Information Technology'),
  ('Антон', 'Антонов', '2001-11-30', '+380991234567', 'CS-101', 'M', 2020, 'Computer Science'),
  ('Микола', 'Ткаченко', '1999-12-25', '+380501234568', 'CS-101', 'M', 2019, 'Computer Science'),
  ('Світлана', 'Клименко', '2000-09-18', '+380671234568', 'IT-102', 'F', 2021, 'Information Technology'),
  ('Іван', 'Бондаренко', '2002-03-22', '+380931234568', 'CS-103', 'M', 2022, 'Computer Science'),
  ('Катерина', 'Мазуренко', '2001-04-14', '+380631234568', 'IT-104', 'F', 2022, 'Information Technology'),
  ('Володимир', 'Антонов', '2000-10-01', '+380991234568', 'CS-103', 'M', 2022, 'Computer Science'),
  ('Оксана', 'Жук', '2001-07-09', '+380501234569', 'IT-104', 'F', 2022, 'Information Technology'),
  ('Ярослав', 'Черненко', '2002-02-11', '+380671234569', 'CS-103', 'M', 2022, 'Computer Science'),
  ('Тетяна', 'Гавриленко', '2000-05-17', '+380931234569', 'IT-104', 'F', 2021, 'Information Technology'),
  ('Микола', 'Руденко', '1999-11-11', '+380631234569', 'CS-101', 'M', 2020, 'Computer Science'),
  ('Вікторія', 'Гриценко', '2001-01-19', '+380991234569', 'IT-102', 'F', 2021, 'Information Technology'),
  ('Антон', 'Ситник', '2002-06-30', '+380501234570', 'CS-103', 'M', 2022, 'Computer Science'),
  ('Наталія', 'Поліщук', '2000-08-05', '+380671234570', 'IT-104', 'F', 2022, 'Information Technology'),
  ('Микола', 'Шулга', '1999-09-28', '+380501234570', 'CS-101', 'M', 2020, 'Computer Science'),
  ('Вася', 'Жовтенко', '2001-12-12', '+380631234570', 'IT-102', 'M', 2021, 'Information Technology'),
  ('Анастасія', 'Федорова', '2002-04-03', '+380991234570', 'CS-103', 'F', 2022, 'Computer Science'),
  ('Вася', 'Левченко', '2001-11-15', '+380501234571', 'IT-102', 'M', 2021, 'Information Technology'),
  ('Марія', 'Голуб', '2000-03-27', '+380671234571', 'CS-101', 'F', 2020, 'Computer Science'),
  ('Петро', 'Петренко', '2001-07-07', '+380931234571', 'IT-102', 'M', 2021, 'Information Technology'),
  ('Вася', 'Мусієнко', '2002-09-13', '+380631234571', 'CS-103', 'M', 2022, 'Computer Science'),
  ('Юлія', 'Сокол', '2000-06-23', '+380991234571', 'IT-104', 'F', 2022, 'Information Technology');



CREATE TABLE courses (
  id SERIAL PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  description VARCHAR(100) NOT NULL,
  hours INTEGER NOT NULL CHECK (hours > 0)
);


INSERT INTO courses (title, description, hours)
VALUES
  ('Основи програмування на JavaScript', 'Вивчення синтаксису, структур даних та алгоритмів в Python.', 40),
  ('Веб-розробка на React.js', 'Створення інтерактивних інтерфейсів користувача за допомогою React.js.', 60),
  ('Бази даних SQL', 'Ознайомлення з мовою SQL та проектування реляційних баз даних.', 30),
  ('Машинне навчання', 'Вступ до машинного навчання, алгоритми класифікації та регресії.', 50),
  ('Кібербезпека', 'Захист інформаційних систем та мереж від кіберзагроз.', 35);




CREATE TABLE exams (
  id SERIAL PRIMARY KEY,
  mark FLOAT CHECK (mark >= 0 AND mark <= 100),
  student_id INTEGER REFERENCES students(id)
             ON UPDATE CASCADE
             ON DELETE CASCADE,
  course_id INTEGER REFERENCES courses(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

INSERT INTO exams (mark, student_id, course_id)
VALUES
  (90.00, 1, 1),
  (85.00, 2, 2),
  (75.00, 3, 3),
  (68.00, 4, 4),
  (55.00, 5, 5),
  (95.00, 6, 1),
  (79.00, 7, 2),
  (63.00, 8, 3),
  (29.00, 9, 4),
  (82.00, 10, 5),
  (75.00, 11, 1),
  (60.00, 12, 2),
  (46.00, 13, 3),
  (87.00, 14, 4),
  (70.00, 15, 5),
  (57.00, 16, 1),
  (95.00, 17, 2),
  (81.00, 18, 3),
  (67.00, 19, 4),
  (53.00, 20, 5);

--Відобразити, коли відбувся перший набір (мінімальний рік ступу).

SELECT MIN(entered_at) AS first_admission_year
FROM students;

-- Відобразити кількість студентів, які навчаються у кожній групі.

SELECT group_code, COUNT(*) AS students_count
FROM students
GROUP BY group_code;


--Відобразити загальну кількість студентів, які вступили 2018 року.


INSERT INTO students (first_name, last_name, birthday, phone_number, group_code, gender, entered_at, department)
VALUES
  ('Богдан', 'Іваніщак', '2001-02-15', '+380501234567', 'CS-101', 'M', 2018, 'Computer Science');

SELECT COUNT (*)
FROM students
WHERE entered_at = 2018;

--*Відобразити середній вік студентів жіночої статі кожного факультету. Список впорядкувати за зменшенням віку. Стовпчик із середнім віком назвати avg_age. Спойлер: 1 -  агрегатна функція MIN, 2 - групування GROUP BY + агрегатна функція COUNT, 3 - фільтрація WHERE + агрегатна функція COUNT


SELECT department, AVG(AGE(CURRENT_DATE, birthday)) AS avg_age
FROM students
WHERE gender = 'F'
GROUP BY department
ORDER BY avg_age DESC;


-- Відобразити імена та прізвища студентів та назви курсів, що ними вивчаються.

SELECT s.first_name, s.last_name, c.title
FROM students s
INNER JOIN exams e ON s.id = e.student_id
INNER JOIN courses c ON e.course_id = c.id;

-- Відобразити бали студента Петра Петренка (змінив на Микола Шевченко, оскільки Петро цей курс не проходив, повертає 0 рядків) з дисципліни «Основи програмування».

SELECT e.mark
FROM students s
INNER JOIN exams e ON s.id = e.student_id
INNER JOIN courses c ON e.course_id = c.id
WHERE s.first_name = 'Микола' AND s.last_name = 'Шевченко' AND c.title = 'Основи програмування на JavaScript';

--Відобразити студентів, які мають бали нижче 60.

SELECT s.first_name, s.last_name, e.mark
FROM students s
JOIN exams e ON s.id = e.student_id
WHERE e.mark < 60;

--Відобразити студентів, які прослухали дисципліну «Основи програмування» та мають за неї оцінку.

SELECT s.first_name, s.last_name, e.mark
FROM students s
INNER JOIN exams e ON s.id = e.student_id
INNER JOIN courses c ON e.course_id = c.id
WHERE c.title = 'Основи програмування на JavaScript' AND e.mark IS NOT NULL;

-- Відобразити середній бал та кількість курсів, які відвідав кожен студент.

SELECT s.first_name, s.last_name, 
    AVG(e.mark) AS avarage_mark,
    COUNT(DISTINCT c.id) AS students_count
FROM students s
INNER JOIN exams e ON s.id = e.student_id
INNER JOIN courses c ON e.course_id = c.id
GROUP BY s.first_name, s.last_name;


--Відобразити студентів, які мають середній бал вище 81.
SELECT s.first_name, s.last_name, e.mark
FROM students s
JOIN exams e ON s.id = e.student_id
WHERE e.mark > 81
ORDER BY mark DESC;

--*Відобразити дисципліни, які ще не прослухав жоден студент.

INSERT INTO courses (title, description, hours)
VALUES ('Вступ до програмування', 'Ознайомлення з основами програмування, алгоритмами та структурами даних.', 40);


SELECT c.title
FROM courses c
LEFT JOIN exams e ON c.id = e.course_id
WHERE e.student_id IS NULL;

--------------------------------------------------
-------------------ПІДЗАПИТИ----------------------
--------------------------------------------------

--Отримати список студентів, у яких день народження збігається із днем народження Петра Петренка.

INSERT INTO students (first_name, last_name, birthday, phone_number, group_code, gender, entered_at, department)
VALUES
  ('Олександр', 'Грицак', '2001-07-07', '+380504533223', 'CS-101', 'M', 2018, 'Computer Science');


SELECT first_name, last_name, birthday
FROM students
WHERE birthday = (
    SELECT birthday
    FROM students 
    WHERE first_name = 'Петро' AND last_name = 'Петренко'
);

--- Відобразити студентів, які мають середній бал вище, ніж Антона Антонова.

SELECT s.first_name, s.last_name, AVG(e.mark) AS average_mark
FROM students s
JOIN exams e ON s.id = e.student_id
GROUP BY s.id
HAVING AVG(e.mark) > (
    SELECT AVG(e2.mark)
    FROM exams e2
    JOIN students s2 ON e2.student_id = s2.id
    WHERE s2.first_name = 'Антон' AND s2.last_name = 'Антонов'
);


---- Отримати список предметів, у яких кількість годин більше, ніж у "Вступ до програмування".

SELECT title, description, hours
FROM courses
WHERE hours > (
    SELECT hours
    FROM courses
    WHERE title = 'Вступ до програмування'
);

--- Отримати список студент | предмет | оцінка де оцінка має бути більшою за будь-яку оцінку Антона Антонова.

SELECT s.first_name, s.last_name AS student, c.title AS course, e.mark AS assessment
FROM exams e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id
WHERE e.mark > (
    SELECT MAX(e2.mark)
    FROM exams e2
    JOIN students s2 ON e2.student_id = s2.id
    WHERE s2.first_name = 'Антон' AND s2.last_name = 'Антонов'
);

---*Отримати перелік студентів, які ще не вивчали жодного предмету (спробуйте це зробити різними способами).

SELECT s.first_name, s.last_name
FROM students s
LEFT JOIN exams e ON s.id = e.student_id
WHERE e.id IS NULL;

--
SELECT s.first_name, s.last_name
FROM students s
WHERE s.id NOT IN (
    SELECT e.student_id
    FROM exams e
);

--
SELECT s.first_name, s.last_name
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM exams e
    WHERE e.student_id = s.id
);


--- (Умовні вирази:) Вивести студент | предмет | оцінка щоб оцінка виводилася у літерному вигляді "відмінно", "добре" або "задовільно". (за шкалою переведення, наприклад, 0-59 – незадовільно	60-74 б – задовідно 75-89 б – добре 90-100 б – відмінно)


SELECT s.first_name AS student, c.title AS course, 
    CASE 
        WHEN e.mark < 60 THEN 'незадовільно'
        WHEN e.mark >= 60 AND e.mark < 75 THEN 'задовільно'
        WHEN e.mark >= 75 AND e.mark < 90 THEN 'добре'
        WHEN e.mark >= 90 THEN 'відмінно'
    END AS grade
FROM exams e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id
ORDER BY grade;

