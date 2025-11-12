USE retail_analytics;

-- 1) Atomic sales detail (base for all)
CREATE OR REPLACE VIEW vw_sales_detail AS
SELECT
  o.order_id,
  o.order_date,
  o.required_date,
  o.shipped_date,
  (o.shipped_date > o.required_date) AS is_delayed,
  o.store_id,
  s.store_name,
  s.city, s.state,
  o.staff_id,
  st.first_name AS staff_first, st.last_name AS staff_last,
  o.customer_id,
  c.first_name AS cust_first, c.last_name AS cust_last,
  oi.item_id,
  oi.product_id,
  p.product_name,
  p.brand_id, b.brand_name,
  p.category_id, cat.category_name,
  p.model_year,
  oi.quantity,
  oi.list_price,
  oi.discount,
  (oi.quantity * oi.list_price * (1 - oi.discount)) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN brands b ON b.brand_id = p.brand_id
JOIN categories cat ON cat.category_id = p.category_id
JOIN stores s ON s.store_id = o.store_id
JOIN staffs st ON st.staff_id = o.staff_id
JOIN customers c ON c.customer_id = o.customer_id;

-- 2) Daily KPIs by store
CREATE OR REPLACE VIEW vw_kpi_overview AS
SELECT
  order_date,
  store_id,
  store_name,
  state,
  COUNT(DISTINCT order_id) AS total_orders,
  COUNT(DISTINCT customer_id) AS unique_customers,
  SUM(revenue) AS total_sales,
  CASE WHEN COUNT(DISTINCT order_id)=0 THEN 0
       ELSE SUM(revenue) / COUNT(DISTINCT order_id) END AS avg_order_value,
  SUM(CASE WHEN is_delayed THEN 1 ELSE 0 END) AS delayed_shipments
FROM vw_sales_detail
GROUP BY order_date, store_id, store_name, state;

-- 3) Sales by date x product hierarchy x store
CREATE OR REPLACE VIEW vw_sales_by_hierarchy AS
SELECT
  order_date,
  state, store_id, store_name,
  category_id, category_name,
  brand_id, brand_name,
  product_id, product_name,
  SUM(quantity) AS units,
  SUM(revenue) AS revenue
FROM vw_sales_detail
GROUP BY
  order_date, state, store_id, store_name,
  category_id, category_name,
  brand_id, brand_name,
  product_id, product_name;

-- 4) Staff performance
CREATE OR REPLACE VIEW vw_staff_performance AS
SELECT
  staff_id,
  CONCAT(staff_first, ' ', staff_last) AS staff_name,
  store_id, store_name, state,
  COUNT(DISTINCT order_id) AS orders_handled,
  SUM(revenue) AS revenue,
  CASE WHEN COUNT(DISTINCT order_id)=0 THEN 0
       ELSE SUM(revenue)/COUNT(DISTINCT order_id) END AS avg_order_value
FROM vw_sales_detail
GROUP BY staff_id, staff_first, staff_last, store_id, store_name, state;

-- 5) Helper: last 30 days sales per store-product
CREATE OR REPLACE VIEW vw_sales_30 AS
SELECT
  sd.store_id,
  sd.product_id,
  SUM(sd.quantity) AS qty_30,
  GREATEST(DATEDIFF(MAX(sd.order_date), DATE_SUB(MAX(sd.order_date), INTERVAL 29 DAY)) + 1, 1) AS days
FROM vw_sales_detail sd
WHERE sd.order_date >= DATE_SUB((SELECT MAX(order_date) FROM vw_sales_detail), INTERVAL 29 DAY)
GROUP BY sd.store_id, sd.product_id;

-- 6) Inventory coverage (days-of-stock)
CREATE OR REPLACE VIEW vw_inventory_coverage AS
SELECT
  st.store_id,
  s.store_name,
  st.product_id,
  p.product_name,
  COALESCE(st.quantity, 0) AS on_hand,
  COALESCE(s30.qty_30, 0) AS last_30d_units,
  CASE WHEN COALESCE(s30.days,0)=0 THEN 0
       ELSE COALESCE(s30.qty_30,0)/s30.days END AS daily_avg,
  CASE
    WHEN COALESCE(s30.qty_30,0)=0 THEN NULL
    WHEN COALESCE(s30.days,0)=0 THEN NULL
    WHEN COALESCE(s30.qty_30,0)/s30.days = 0 THEN NULL
    ELSE ROUND(st.quantity / (s30.qty_30/s30.days), 1)
  END AS coverage_days
FROM stocks st
JOIN stores s ON s.store_id = st.store_id
JOIN products p ON p.product_id = st.product_id
LEFT JOIN vw_sales_30 s30
  ON s30.store_id = st.store_id AND s30.product_id = st.product_id;

-- 7) Customer metrics (RFM-lite)
CREATE OR REPLACE VIEW vw_customer_metrics AS
SELECT
  customer_id,
  MIN(order_date) AS first_order_date,
  MAX(order_date) AS last_order_date,
  DATEDIFF(MAX(order_date), MIN(order_date)) AS tenure_days,
  COUNT(DISTINCT order_id) AS orders_count,
  SUM(revenue) AS total_spend,
  CASE WHEN COUNT(DISTINCT order_id)=0 THEN 0
       ELSE SUM(revenue)/COUNT(DISTINCT order_id) END AS avg_order_value
FROM vw_sales_detail
GROUP BY customer_id;
