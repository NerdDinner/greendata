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

--Пример Автоматический: от 1000 до 5000 руб.
INSERT INTO orders (order_num, client_id, status, total_price, executor_id) 
VALUES ('2023-001', 1, 'IN_DELIVERY', 2300, 3);

INSERT INTO order_items (order_id, product_id, price_at_purchase) VALUES 
(1, 1, 1500),
(1, 4, 800);

--Пример Ручное подтверждение: от 5000 руб.
INSERT INTO orders (order_num, client_id, status, total_price, executor_id) 
VALUES ('2023-002', 1, 'AWAITING_CONFIRMATION', 5800, 2);

INSERT INTO order_items (order_id, product_id, price_at_purchase) VALUES 
(2, 3, 3000),
(2, 7, 2800);

--Пример Маркетинговая акция: 2 товара > 3000 + подарок
INSERT INTO orders (order_num, client_id, status, total_price) 
VALUES ('2023-003', 1, 'IN_DELIVERY', 3050);

INSERT INTO order_items (order_id, product_id, price_at_purchase, is_gift) VALUES 
(3, 5, 1700, FALSE), 
(3, 10, 1350, FALSE),
(3, 3, 0, TRUE);