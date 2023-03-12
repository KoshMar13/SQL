USE ht_4;

/*1  Создайте таблицу users_old, аналогичную таблице users. 
Создайте процедуру, с помощью которой можно переместить любого (одного) 
пользователя из таблицы users в таблицу users_old. 
(использование транзакции с выбором commit или rollback – обязательно).*/

DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

DROP PROCEDURE IF EXISTS sp_user_transfer;
DELIMITER //
CREATE PROCEDURE sp_user_transfer(old_user_id BIGINT)
BEGIN
	INSERT INTO users_old
    SELECT * FROM users
    WHERE id = old_user_id;
    DELETE FROM users
    WHERE id = old_user_id;
    ROLLBACK;
END//
DELIMITER ;
CALL sp_user_transfer(1);

/* 2 Создайте хранимую функцию hello(), 
которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", 
с 00:00 до 6:00 — "Добрый вечер".
*/

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS TINYTEXT NOT DETERMINISTIC
LANGUAGE SQL DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER
BEGIN
	DECLARE now_time TIME;
	SET now_time = current_time;
    CASE
		WHEN now_time between '06:00:00' and '11:59:59'
			THEN RETURN 'Доброе утро';
		WHEN now_time between '12:00:00' and '17:59:59'
			THEN RETURN 'Добрый день';
		WHEN now_time between '18:00:00' and '23:59:59'
			THEN RETURN 'Добрый вечер';
		ELSE RETURN 'Добрый вечер';
	END CASE;
END//
DELIMITER ;

SELECT hello();

/* 3 (по желанию)* Создайте таблицу logs типа Archive. 
Пусть при каждом создании записи в таблицах users, communities и messages 
в таблицу logs помещается время и дата создания записи, 
название таблицы, идентификатор первичного ключа.
*/
