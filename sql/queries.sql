--Поиск двух самых дешевых товаров, дающих в сумме >= 3000
--6.1.	За два разных товара из интернет-магазина общей стоимостью 3 000 руб. и дороже
WITH CheaperPair AS (
    SELECT 
        p1.NAME as p1_name, p1.PRICE as p1_price,
        p2.NAME as p2_name, p2.PRICE as p2_price
    FROM Products p1
    JOIN Products p2 ON p1.ID < p2.ID -- исключить дубликаты и пары "товар сам с собой"
    WHERE (p1.PRICE + p2.PRICE) >= 3000
    ORDER BY (p1.PRICE + p2.PRICE) ASC
    LIMIT 1
),
--Поиск самого дорогого товара (подарок)
MostExpensive AS (
    SELECT NAME, PRICE FROM Products
    ORDER BY PRICE DESC
    LIMIT 1
)
--Результат
SELECT p1_name AS NAME, p1_price AS PRICE FROM CheaperPair
UNION ALL
SELECT p2_name, p2_price FROM CheaperPair
UNION ALL
SELECT NAME, PRICE FROM MostExpensive;