DROP DATABASE IF EXISTS ht_3;
CREATE DATABASE ht_3;
USE ht_3;

CREATE TABLE staff
(
	id serial primary key,
    firstname varchar(10) not null,
    lastname varchar(20) not null,
    post varchar(20) not null,
    seniority int,
    salary int,
    age int not null
);

insert into staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', 40, 100000, 60), -- 1
('Пётр', 'Власов', 'Начальник', 8, 70000, 30), -- 2
('Катя', 'Катина', 'Инженер', 2, 70000, 25), -- 3
('Саша', 'Сасин', 'Инженер', 12, 50000, 35), -- 4
('Иван', 'Иванов', 'Рабочий', 40, 30000, 59), -- 5
('Пётр', 'Петров', 'Рабочий', 20, 25000, 40), -- 6
('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35), -- 7
('Антон', 'Антонов', 'Рабочий', 8, 19000, 28), -- 8
('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25), -- 9
('Максим', 'Максимов', 'Рабочий', 2, 11000, 22), -- 10
('Юрий', 'Галкин', 'Рабочий', 3, 12000, 24), -- 11
('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49); -- 12

-- 1 Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания
SELECT id, firstname, lastname, post, seniority, salary, age 
FROM staff
ORDER BY salary DESC;
SELECT id, firstname, lastname, post, seniority, salary, age 
FROM staff
ORDER BY salary;

-- 2 Выведите 5 максимальных заработных плат (salary)
SELECT id, firstname, lastname, post, seniority, salary, age 
FROM staff
ORDER BY salary DESC
LIMIT 5;

-- 3 Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT post, SUM(salary)
FROM staff
GROUP BY post;

/* 4 Найдите кол-во сотрудников с специальностью (post) 
«Рабочий» в возрасте от 24 до 49 лет включительно */
SELECT post, age
FROM staff
WHERE post = 'Рабочий'
HAVING age between 24 and 49;

-- 5 Найдите количество специальностей
SELECT COUNT(DISTINCT post) as 'Количество специальностей:' FROM staff ;

-- 6 Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
SELECT post 
FROM staff
GROUP BY post
HAVING AVG(age) <= 30;