2.Напишите SELECT-запрос, который выводит название товара, производителя и цену для товаров, 
количество которых превышает 2.
SELECT product_name, manufacturer, price FROM my_best_shema.phones WHERE product_count>'2';

3.Выведите SELECT-запросом весь ассортимент товаров марки “Samsung”.
SELECT * FROM my_best_shema.phones WHERE manufacturer='Samsung';

4.* С помощью SELECT-запроса с оператором LIKE/REGEXP найти:
4.1.* Товары, в которых есть упоминание "Iphone"
4.2.* Товары, в которых есть упоминание "Samsung"
4.3.* Товары, в названии которых есть ЦИФРЫ
4.4.* Товары, в названии которых есть ЦИФРА "8"

4.1 SELECT * FROM my_best_shema.phones WHERE product_name LIKE '%Iphone%' or manufacturer LIKE '%Iphone%';
4.2 SELECT * FROM my_best_shema.phones WHERE product_name LIKE '%Samsung%' or manufacturer LIKE '%Samsung%';
4.3 SELECT * FROM my_best_shema.phones WHERE product_name REGEXP '[A-z]*[0-9]+[A-z]*';
4.4 SELECT * FROM my_best_shema.phones WHERE product_name LIKE '%8%';