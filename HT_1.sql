SELECT * FROM ht_1.cell_phones;

-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT product_name, manufacturer, price 
FROM ht_1.cell_phones 
WHERE product_count > 2;

/*
3. Выведите весь ассортимент товаров марки “Samsung
*/
SELECT id, product_name, manufacturer, product_count, price 
FROM ht_1.cell_phones
WHERE manufacturer = 'Samsung';


-- 4.1 С помощью регулярных выражений найти товары, в которых есть упоминание "Iphone"
SELECT id, product_name, manufacturer, product_count, price 
FROM ht_1.cell_phones
WHERE product_name LIKE '%iPhone%';

-- 4.2 С помощью регулярных выражений найти товары, в которых есть упоминание"Samsung"
SELECT id, product_name, manufacturer, product_count, price 
FROM ht_1.cell_phones
WHERE manufacturer LIKE '%Samsung%';

-- 4.3 С помощью регулярных выражений найти товары, в которых есть ЦИФРЫ
SELECT id, product_name, manufacturer, product_count, price 
FROM ht_1.cell_phones
WHERE product_name REGEXP '[0-9]';

-- 4.4 С помощью регулярных выражений найти товары, в которых есть ЦИФРА "8"
SELECT id, product_name, manufacturer, product_count, price 
FROM ht_1.cell_phones
WHERE product_name LIKE '%8%';