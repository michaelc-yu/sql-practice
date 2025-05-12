
CREATE TABLE users (
  id INT PRIMARY KEY,     
  name VARCHAR(100),     
  email VARCHAR(100), 
  signup_date DATETIME
);
CREATE TABLE courses (
  id INT PRIMARY KEY,          
  title VARCHAR(100),              
  description VARCHAR(300),
  created_at DATETIME
);
CREATE TABLE enrollments (
  user_id INT,
  course_id INT,
  enrolled_at DATETIME,
  PRIMARY KEY (user_id, course_id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO users VALUES (1, 'Alice', 'alice@gmail.com', '2024-01-15 10:30:00');
INSERT INTO users VALUES (2, 'Bob', 'bob@gmail.com', '2025-03-05 08:15:00');
INSERT INTO users VALUES (3, 'Felix', 'felix@hotmail.com', '2023-05-01 12:10:00');

INSERT INTO courses values (1, 'Machine Learning', 'An introductory course in ML', '2018-01-01 00:00:00');
INSERT INTO courses values (2, 'Statistics', 'Statistics important for ML', '2019-01-01 00:00:00');
INSERT INTO courses values (3, 'Philosophy', 'Philosophy 101 taught by Dr. Bob', '2016-01-01 00:00:00');

INSERT INTO enrollments VALUES (1, 1, '2024-02-01 09:00:00');  -- Alice → ML
INSERT INTO enrollments VALUES (1, 2, '2024-02-05 14:00:00');  -- Alice → Stats
INSERT INTO enrollments VALUES (2, 1, '2025-03-06 10:00:00');  -- Bob → ML
INSERT INTO enrollments VALUES (3, 3, '2023-05-05 12:00:00');  -- Felix → Philosophy

