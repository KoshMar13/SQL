-- 1.Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными.
DROP database IF exists gh_2;
CREATE database ht_2;
USE ht_2;
CREATe table sales
(
	id serial primary key,
    order_date date not null,
    count_product int not null
);

insert into sales (order_date, count_product)
VALUES
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

-- 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
SELECT id as 'id заказа',
CASE 
	WHEN count_product < 100 
		THEN 'Маленький заказ'
    WHEN count_product >= 100 and count_product <= 300
		THEN 'Средний заказ'
	WHEN count_product > 300
		THEN 'Большой заказ'
END as 'Тип заказа'
FROM sales;

/*3. Создайте таблицу “orders”, заполните ее значениями. 
Выберите все заказы. 
В зависимости от поля order_status выведите столбец full_order_status: 
OPEN – «Order is in open state» ; 
CLOSED - «Order is closed»; 
CANCELLED - «Order is cancelled»
*/
DROP TABLE IF EXISTS orders;
CREATE table orders
(
	id serial primary key,
    employee_id varchar(20) not null,
    amount decimal (5, 2) not null,
    order_status varchar(20) not null
);

insert into orders (employee_id, amount, order_status)
VALUES
('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');

SELECT id, employee_id, amount, order_status,
IF(order_status = 'OPEN', 'Order is open', -- Мне не понравилась формулиовка "Order is in open state", поэтому заменил. Без обид.
	IF(order_status = 'CLOSED', 'Order is closed', 'Order is cancelled'))
as full_order_status
FROM orders;

