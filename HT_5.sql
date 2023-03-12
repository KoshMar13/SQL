USE ht_4;

-- 1  Создайте представление, 
-- в которое попадет информация о пользователях (имя, фамилия, город и пол), 
-- которые не старше 20 лет.

CREATE OR REPLACE VIEW v_young_users AS
SELECT 
u.firstname, 
u.lastname,
p.hometown, 
p.gender 
FROM users u
JOIN profiles p ON p.user_id = u.id
WHERE id in
(SELECT id
from media 
Where user_id in 
(SELECT user_id
from profiles 
WHERE DATE_FORMAT(FROM_DAYS(DATEDIFF(now(),birthday)), '%Y') <=20));

/* 2 Найдите кол-во отправленных сообщений каждым пользователем 
и выведите ранжированный список пользователей, 
указав имя и фамилию пользователя, 
количество отправленных сообщений и место в рейтинге 
(первое место у пользователя с максимальным количеством сообщений) . 
(используйте DENSE_RANK)
*/

/*SELECT DISTINCT user_id, firstname, lastname, 
COUNT(message_id) OVER(PARTITION BY user_id) as count_messages,
DENSE_RANK() OVER (PARTITION BY user_id) as rank_message
FROM
(SELECT
u.id as user_id, u.firstname, u.lastname,
m.id as message_id, m.from_user_id
FROM users u
RIGHT JOIN messages m on m.from_user_id = u.id) AS list
ORDER BY count_messages DESC;
*/

/*решите задачу по частям - сначала найдите - сколько каждый пользователь отправил сообщений
а уже потом к этой выборке оконную функцию примените*/

SELECT *, DENSE_RANK() OVER (ORDER BY count_mess DESC) as rank_message
FROM
(SELECT 
	m.from_user_id as user_id, 
	u.firstname, 
	u.lastname, 
    COUNT(m.from_user_id) as count_mess
FROM messages m
LEFT JOIN users u on m.from_user_id = u.id
GROUP BY m.from_user_id) AS list;

/* 3 Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) 
и найдите разницу дат отправления между соседними сообщениями, получившегося списка. 
(используйте LEAD или LAG)
*/
SELECT id, from_user_id, to_user_id, created_at,
LAG(created_at) OVER w AS prev_date
FROM messages
WINDOW w AS (ORDER BY created_at);