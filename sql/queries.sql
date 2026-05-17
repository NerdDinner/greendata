--6.1.	За два разных товара из интернет-магазина общей стоимостью 3 000 руб. и дороже, дают третий товар в подарок. 
--Для анализа возможных затрат на данную маркетинговую акцию владельцы магазина хотят получить представление о том, 
--какие два самых дешевых товара будут соответствовать условиям акции, а какой товар (самый дорогой) будет предоставлен бесплатно. 

--поиск двух самых дешевых товаров, в сумме >= 3000
with cheaper_pair as (
    select 
        p1.name as p1_name, p1.price as p1_price,
        p2.name as p2_name, p2.price as p2_price
    from products p1
    join products p2 on p1.id < p2.id -- исключить дубликаты и пары "товар сам с собой"
    where (p1.price+p2.price) >= 3000
    order by (p1.price+p2.price) asc
    limit 1
),
--поиск самого дорогого товара (подарок)
most_expensive as (
    select 
        name, 
        price 
    from products
    order by price desc
    limit 1
)
--результат (SQL-запрос, который вернет три товара с учетом критериев, представленных в п. 6)

--первый товар из пары дешевых
select 
    p1_name as name, 
    p1_price as price 
from cheaper_pair

union all
--второй товар из пары дешевых
select 
    p2_name, 
    p2_price 
from cheaper_pair

union all
--самый дорогой подарок
select 
    name, 
    price 
from most_expensive;
