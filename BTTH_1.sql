DROP DATABASE IF EXISTS mini_mart_db;
CREATE DATABASE mini_mart_db;
USE mini_mart_db;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    address VARCHAR(255),
    customer_type ENUM('Normal', 'VIP') DEFAULT 'Normal'
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('completed', 'cancelled') DEFAULT 'completed',
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE order_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO customers (full_name, phone, address, customer_type) VALUES
('Nguyen Van A', '0912345671', 'Ha Noi', 'VIP'),
('Tran Thi B', '0912345672', 'TP HCM', 'VIP'),
('Le Van C', '0912345673', 'Da Nang', 'Normal'),
('Pham Minh D', '0912345674', 'Can Tho', 'Normal'),
('Hoang Lan E', '0912345675', 'Hai Phong', 'Normal'),
('Do Hung F', '0912345676', 'Hue', 'Normal'),
('Bui Bich G', '0912345677', 'Da Lat', 'Normal');

INSERT INTO products (product_name, category, price, stock) VALUES
('Gao Thom', 'Thuc Pham', 200000, 50),
('Mi Tom', 'Thuc Pham', 5000, 100),
('Sua Tuoi', 'Do Uong', 35000, 20),
('Nuoc Khoang', 'Do Uong', 5000, 200),
('Bia Sai Gon', 'Do Uong', 18000, 15),
('Chao Chien', 'Gia Dung', 150000, 10),
('Noi Com Dien', 'Gia Dung', 800000, 5),
('Thit Heo', 'Thuc Pham', 120000, 30),
('Nuoc Lau San', 'Gia Dung', 45000, 40),
('Khan Giay', 'Gia Dung', 15000, 0);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2023-10-01 10:00:00', 'completed'),
(2, '2023-10-02 11:30:00', 'completed'),
(3, '2023-10-03 09:15:00', 'completed'),
(4, '2023-10-04 15:45:00', 'completed'),
(5, '2023-10-05 18:20:00', 'cancelled');

INSERT INTO order_details (order_id, product_id, quantity, total_price) VALUES
(1, 1, 1, 200000), 
(1, 2, 5, 25000), 
(1, 3, 2, 70000),
(2, 4, 10, 50000), 
(2, 5, 6, 108000), 
(2, 6, 1, 150000),
(3, 1, 1, 200000), 
(3, 8, 1, 120000),
(4, 9, 1, 45000), 
(4, 2, 10, 50000),
(5, 7, 1, 800000), 
(5, 3, 2, 70000);

UPDATE products 
SET stock = stock - 5 
WHERE id = 1;

SELECT * FROM products WHERE id = 1;

SELECT * FROM customers;

SELECT c.full_name, o.id as order_id 
FROM customers c 
LEFT JOIN orders o ON c.id = o.customer_id 
WHERE o.id IS NULL;