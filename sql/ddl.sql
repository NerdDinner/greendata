--пользователи
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    fio VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    role VARCHAR(50) NOT NULL DEFAULT 'CLIENT' CHECK (role IN ('CLIENT', 'MANAGER', 'COURIER'))
);
COMMENT ON COLUMN users.role IS 'Роль в системе: CLIENT, MANAGER, COURIER';

--товары
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    qty DECIMAL NOT NULL DEFAULT 0
);

COMMENT ON COLUMN products.qty IS 'Остаток товара на складе';

--корзина пользователя
CREATE TABLE cart (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    qty DECIMAL DEFAULT 1 CHECK (quantity > 0)
);

COMMENT ON COLUMN cart.qty IS 'Количество товара';

COMMENT ON TABLE cart IS 'Корзина';


--заказы
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
COMMENT ON COLUMN orders.payment_method IS 'Способ оплаты при получении (CASH/CARD)';
COMMENT ON COLUMN orders.delivery_type IS 'Способ доставки (HOME/STORE)';
COMMENT ON COLUMN orders.confirmed_at IS 'Время подтверждения менеджером';


--состав заказа
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    is_gift BOOLEAN DEFAULT FALSE,
    qty DECIMAL DEFAULT 1
);

COMMENT ON COLUMN order_items.price_at_purchase IS 'Цена товара, зафиксированная в момент оформления';
COMMENT ON COLUMN order_items.is_gift IS 'Признак подарка по акции';
