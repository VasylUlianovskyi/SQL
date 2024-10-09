CREATE DATABASE users;

CREATE TABLE  users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50),
  email VARCHAR(50) UNIQUE NOT NULL CHECK ( email <> ''),
  tel_number CHAR(13) NOT NULL UNIQUE CHECK (tel_number LIKE '+380_________'),
  birthday DATE CHECK (birthday <= CURRENT_DATE),
  is_male BOOLEAN,
  orders_count SMALLINT CHECK (orders_count >= 0) DEFAULT 0
);

INSERT INTO users (first_name, last_name, email, tel_number, birthday, is_male)
VALUES  ('Test', 'Testovych', 'mail@mail.mail','+380123456789', '2000-01-20', TRUE);


INSERT INTO users (first_name, last_name, email, tel_number, birthday, is_male, orders_count)
VALUES  ('Test', 'Testovych', 'mail1@mail.mail','+380123456788', '2000-01-20', TRUE, 20);

INSERT INTO users (first_name, last_name, email, tel_number, birthday, is_male)
VALUES  ('Test', 'Testovych', 'mai3@mail.mail','+3801234', '2000-01-20', TRUE);

INSERT INTO users (last_name, email, tel_number, birthday, is_male)
VALUES  ('Testovych', 'maila3@mail.mail','+3801234', '2000-01-20', TRUE);

SELECT * 
FROM users;

ALTER TABLE users ADD COLUMN id_card CHAR(9)UNIQUE CHECK (id_card ~ '\d{9}');
UPDATE users
SET id_card = '1234567'
WHERE id = 1;

ALTER TABLE users DROP COLUMN passport;

ALTER TABLE users ADD COLUMN passport CHAR(8) UNIQUE CHECK (passport ~ '^[A-Z]{2}\d{6}$');

  UPDATE users
      SET passport = 'AA123456'
    WHERE id = 3;