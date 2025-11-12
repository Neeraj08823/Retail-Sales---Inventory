CREATE DATABASE retail_analytics;
USE retail_analytics;

CREATE TABLE brands (
brand_id INT PRIMARY KEY, 
brand_name VARCHAR(100) NOT NULL
);

CREATE TABLE categories (
category_id INT PRIMARY KEY, 
category_name VARCHAR(100) NOT NULL
);

CREATE TABLE stores (
  store_id INT PRIMARY KEY,
  store_name VARCHAR(150) NOT NULL,
  phone VARCHAR(30), email VARCHAR(150),
  street VARCHAR(150), city VARCHAR(80), state CHAR(2), zip_code VARCHAR(10)
);

CREATE TABLE staffs (
  staff_id INT PRIMARY KEY,
  first_name VARCHAR(80) NOT NULL, last_name VARCHAR(80) NOT NULL,
  email VARCHAR(150), phone VARCHAR(30),
  active TINYINT NOT NULL,
  store_id INT NOT NULL,
  manager_id INT NULL,
  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  FOREIGN KEY (manager_id) REFERENCES staffs(staff_id)
);

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  first_name VARCHAR(80) NOT NULL, last_name VARCHAR(80) NOT NULL,
  phone VARCHAR(30), email VARCHAR(150),
  street VARCHAR(150), city VARCHAR(80), state CHAR(2), zip_code VARCHAR(10)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(200) NOT NULL,
  brand_id INT NOT NULL,
  category_id INT NOT NULL,
  model_year INT NOT NULL,
  list_price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_status TINYINT NOT NULL,
  order_date DATE NOT NULL,
  required_date DATE NOT NULL,
  shipped_date DATE,
  store_id INT NOT NULL,
  staff_id INT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  FOREIGN KEY (staff_id) REFERENCES staffs(staff_id)
);

CREATE TABLE order_items (
  order_id INT NOT NULL,
  item_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  list_price DECIMAL(10,2) NOT NULL,
  discount DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (order_id, item_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE stocks (
  store_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (store_id, product_id),
  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE INDEX ix_orders_dates ON orders(order_date, required_date, shipped_date);
CREATE INDEX ix_orders_store_staff ON orders(store_id, staff_id);
CREATE INDEX ix_order_items_prod ON order_items(product_id);
CREATE INDEX ix_stocks_store_prod ON stocks(store_id, product_id);