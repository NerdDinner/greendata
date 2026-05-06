-- =============================================
-- Схема базы данных ИС «Авиа-сувениры»
-- =============================================

-- 1. Справочник пользователей
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    fio VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    role VARCHAR(50) NOT NULL DEFAULT 'CLIENT' CHECK (role IN ('CLIENT', 'MANAGER', 'COURIER')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE users IS 'Информация о клиентах и сотрудниках ООО Авиа-сувениры';
COMMENT ON COLUMN users.fio IS 'ФИО пользователя';
COMMENT ON COLUMN users.phone IS 'Номер телефона';
COMMENT ON COLUMN users.role IS 'Роль в системе: CLIENT, MANAGER, COURIER';


-- 2. Справочник товаров
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    qty integer NOT NULL DEFAULT 0
);

COMMENT ON TABLE products IS 'Каталог товаров';
COMMENT ON COLUMN products.name IS 'Наименование товара';
COMMENT ON COLUMN products.price IS 'Стоимость';
COMMENT ON COLUMN products.qty IS 'Остаток товара на складе';


-- 3. Корзина
CREATE TABLE cart (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity INTEGER DEFAULT 1 CHECK (quantity > 0)
);

COMMENT ON TABLE cart IS 'Корзина';


-- 4. Заказы
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    order_num VARCHAR(50) UNIQUE NOT NULL,
    client_id INTEGER NOT NULL REFERENCES users(id),
    status VARCHAR(50) NOT NULL CHECK (status IN ('NEW', 'IN_DELIVERY', 'AWAITING_CONFIRMATION', 'CANCELLED', 'COMPLETED')),
    total_price DECIMAL(10, 2) NOT NULL DEFAULT 0,
    
    payment_method VARCHAR(20) CHECK (payment_method IN ('CASH', 'CARD')),
    delivery_type VARCHAR(20) CHECK (delivery_type IN ('HOME', 'STORE')),
    delivery_address TEXT,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    confirmed_at TIMESTAMP,
    executor_id INTEGER REFERENCES users(id)
);

COMMENT ON TABLE orders IS 'Заказы';
COMMENT ON COLUMN orders.order_num IS 'Уникальный номер заказа';
COMMENT ON COLUMN orders.total_price IS 'Итоговая сумма (валидация на < 1000 руб. на уровне приложения)';
COMMENT ON COLUMN orders.payment_method IS 'Способ оплаты при получении (CASH/CARD)';
COMMENT ON COLUMN orders.delivery_type IS 'Способ доставки (HOME/STORE)';
COMMENT ON COLUMN orders.confirmed_at IS 'Время подтверждения менеджером (для отсчета лимита редактирования заказа от 5000 руб.)';


-- 5. Состав оформленного заказа
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    is_gift BOOLEAN DEFAULT FALSE,
    quantity INTEGER DEFAULT 1
);

COMMENT ON TABLE order_items IS 'Товарный состав конкретного заказа (копия из корзины в момент оформления)';
COMMENT ON COLUMN order_items.price_at_purchase IS 'Цена товара, зафиксированная в момент оформления (не меняется при правке каталога)';
COMMENT ON COLUMN order_items.is_gift IS 'Признак предоставления товара бесплатно по маркетинговой акции';
