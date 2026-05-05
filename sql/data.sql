--Наполнение справочника товаров
INSERT INTO products (name, price) VALUES 
('Кружка с логотипом Boeing', 1500),
('Футболка с самолетом Су-57', 2500),
('Модель самолета Airbus 320', 3000),
('Ремувка', 800),
('Кружка с логотипом Airbus', 1700),
('Футболка с самолетом МиГ-35', 2100),
('Модель самолета Boeing 320', 2800),
('Сувенирная книга с фотографиями самолетов', 1850),
('Бейсболка с эмблемой «Русские авиагонки»', 1100),
('Футболка с эмблемой «Русские авиагонки»', 1350);

--Создание пользователей
INSERT INTO users (fio, phone, role) VALUES 
('Иванов Иван Иванович', '79991234567', 'CLIENT'),
('Петрова Анна Сергеевна', '79990001122', 'MANAGER'),
('Сидоров Алексей', '79995554433', 'COURIER');

--Пример заказа №1 (Автоматический: от 1000 до 5000 руб.)
--Покупает Кружку Boeing и Ремувку (Сумма 2300)
INSERT INTO orders (order_num, client_id, status, total_price, executor_id) 
VALUES ('AVIA-2023-001', 1, 'IN_DELIVERY', 2300, 3);

INSERT INTO order_items (order_id, product_id, price_at_purchase) VALUES 
(1, 1, 1500), --Кружка Boeing
(1, 4, 800);  --Ремувка

--Пример заказа №2 (Ручное подтверждение: от 5000 руб.)
--Покупает две модели самолетов (Сумма 5800)
INSERT INTO orders (order_num, client_id, status, total_price, executor_id) 
VALUES ('AVIA-2023-002', 1, 'AWAITING_CONFIRMATION', 5800, 2);

INSERT INTO order_items (order_id, product_id, price_at_purchase) VALUES 
(2, 3, 3000), --Модель Airbus
(2, 7, 2800); --Модель Boeing

--Пример заказа №3 (Маркетинговая акция: 2 товара > 3000 + подарок)
--Покупает Кружку Airbus (1700) и Футболку Авиагонки (1350) = 3050 руб.
--Получает в подарок Модель Airbus 320 (0 руб. по акции)
INSERT INTO orders (order_num, client_id, status, total_price) 
VALUES ('AVIA-2023-003', 1, 'IN_DELIVERY', 3050);

INSERT INTO order_items (order_id, product_id, price_at_purchase, is_gift) VALUES 
(3, 5, 1700, FALSE), --Кружка Airbus
(3, 10, 1350, FALSE), --Футболка Авиагонки
(3, 3, 0, TRUE);     --Подарок (Модель Airbus)