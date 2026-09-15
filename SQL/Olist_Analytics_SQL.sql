CREATE DATABASE olist_analytics;

USE olist_analytics;

SELECT DATABASE();

-- customers table
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

-- orders table
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME NULL,
    order_delivered_carrier_date DATETIME NULL,
    order_delivered_customer_date DATETIME NULL,
    order_estimated_delivery_date DATETIME NULL
);

-- order items
CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),

    PRIMARY KEY (order_id, order_item_id)
);

-- product table
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT NULL,
    product_description_lenght INT NULL,
    product_photos_qty INT NULL,
    product_weight_g DECIMAL(10,2) NULL,
    product_length_cm DECIMAL(10,2) NULL,
    product_height_cm DECIMAL(10,2) NULL,
    product_width_cm DECIMAL(10,2) NULL
);

-- seller table
CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

-- payments table
CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10,2),

    PRIMARY KEY (order_id, payment_sequential)
);

-- reviews table
CREATE TABLE order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME,

    PRIMARY KEY (review_id)
);

-- geolocation table
CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10,7),
    geolocation_lng DECIMAL(10,7),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);

-- category translation table 
CREATE TABLE product_category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);

SHOW TABLES;

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\ngeolocation'
IGNORE 1 ROWS;

SELECT COUNT(*) AS customer_count
FROM customers;

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL
SELECT 'product_category_translation', COUNT(*) FROM product_category_translation;

DROP TABLE olist_customers_dataset;

SHOW VARIABLES LIKE 'local_infile';

SHOW SESSION VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS customer_count
FROM customers;

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id,
 customer_id,
 order_status,
 order_purchase_timestamp,
 order_approved_at,
 order_delivered_carrier_date,
 order_delivered_customer_date,
 order_estimated_delivery_date);
 
SELECT COUNT(*) AS orders_count
FROM orders;

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id,
 order_item_id,
 product_id,
 seller_id,
 shipping_limit_date,
 price,
 freight_value);
 
SELECT COUNT(*) AS order_items_count
FROM order_items;

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id,
 product_category_name,
 product_name_lenght,
 product_description_lenght,
 product_photos_qty,
 product_weight_g,
 product_length_cm,
 product_height_cm,
 product_width_cm);
 
LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(seller_id,
 seller_zip_code_prefix,
 seller_city,
 seller_state);
 
LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_order_payments_dataset.csv'
INTO TABLE order_payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id,
 payment_sequential,
 payment_type,
 payment_installments,
 payment_value);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(review_id,
 order_id,
 review_score,
 review_comment_title,
 review_comment_message,
 review_creation_date,
 review_answer_timestamp);
 
LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/product_category_name_translation.csv'
INTO TABLE product_category_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_category_name,
 product_category_name_english);
 
LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_geolocation_dataset.csv'
INTO TABLE geolocation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(geolocation_zip_code_prefix,
 geolocation_lat,
 geolocation_lng,
 geolocation_city,
 geolocation_state);
 
SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM customers
UNION ALL
SELECT 'orders', COUNT(*)
FROM orders
UNION ALL
SELECT 'order_items', COUNT(*)
FROM order_items
UNION ALL
SELECT 'products', COUNT(*)
FROM products
UNION ALL
SELECT 'sellers', COUNT(*)
FROM sellers
UNION ALL
SELECT 'order_payments', COUNT(*)
FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*)
FROM order_reviews
UNION ALL
SELECT 'geolocation', COUNT(*)
FROM geolocation
UNION ALL
SELECT 'product_category_translation', COUNT(*)
FROM product_category_translation;

TRUNCATE TABLE geolocation;

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_geolocation_dataset.csv'
INTO TABLE geolocation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
);

SELECT COUNT(*) AS row_count
FROM geolocation;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT review_id) AS unique_review_ids
FROM order_reviews;

SELECT
    COUNT(*) AS missing_review_ids
FROM order_reviews
WHERE review_id IS NULL
   OR review_id = '';
   
SELECT
    COUNT(*) AS missing_order_ids
FROM order_reviews
WHERE order_id IS NULL
   OR order_id = '';
   
SELECT
    review_id,
    order_id,
    review_score,
    review_creation_date
FROM order_reviews
WHERE review_id IS NULL
   OR review_id = ''
LIMIT 10;

DROP TABLE order_reviews;

CREATE TABLE order_reviews (
    review_record_id INT AUTO_INCREMENT PRIMARY KEY,
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
);

SELECT COUNT(*) AS total_rows
FROM order_reviews;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT review_id) AS unique_review_ids
FROM order_reviews;

TRUNCATE TABLE order_reviews;

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
);

SHOW WARNINGS;

TRUNCATE TABLE order_reviews;

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
);

SHOW WARNINGS;

SELECT COUNT(*) AS review_rows
FROM order_reviews;

SHOW WARNINGS;

CREATE TABLE order_reviews_staging (
    review_id VARCHAR(100),
    order_id VARCHAR(100),
    review_score VARCHAR(20),
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date VARCHAR(50),
    review_answer_timestamp VARCHAR(50)
);

TRUNCATE TABLE order_reviews_staging;

LOAD DATA LOCAL INFILE 'C:/Users/Admin/Downloads/olist datasets/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews_staging
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
);

SELECT COUNT(*) AS staging_rows
FROM order_reviews_staging;

TRUNCATE TABLE order_reviews_staging;

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL
SELECT 'product_category_translation', COUNT(*) FROM product_category_translation;

DESCRIBE customers;
DESCRIBE orders;
DESCRIBE order_items;
DESCRIBE order_payments;
DESCRIBE order_reviews;
DESCRIBE products;
DESCRIBE sellers;
DESCRIBE geolocation;
DESCRIBE product_category_translation;

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT customer_id) AS unique_customer_ids,
    COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM customers;

SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS order_percentage
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

SELECT
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM orders;

SELECT
    COUNT(*) AS total_orders,

    SUM(CASE
        WHEN customer_id IS NULL THEN 1
        ELSE 0
    END) AS missing_customer_id,

    SUM(CASE
        WHEN order_purchase_timestamp IS NULL THEN 1
        ELSE 0
    END) AS missing_purchase_date,

    SUM(CASE
        WHEN order_delivered_customer_date IS NULL THEN 1
        ELSE 0
    END) AS missing_delivery_date,

    SUM(CASE
        WHEN order_estimated_delivery_date IS NULL THEN 1
        ELSE 0
    END) AS missing_estimated_date

FROM orders;

SELECT
    COUNT(*) AS total_review_records,
    COUNT(DISTINCT review_id) AS unique_reviews,
    COUNT(DISTINCT order_id) AS reviewed_orders
FROM order_reviews;

-- What is the grain of the orders table?
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_orders
FROM orders;

-- What is the grain of the order_items table?
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_orders,
    COUNT(DISTINCT product_id) AS distinct_products
FROM order_items;

-- How many product items are typically included in an order?
SELECT
    ROUND(AVG(item_count), 2) AS avg_items_per_order,
    MAX(item_count) AS max_items_in_order
FROM (
    SELECT
        order_id,
        COUNT(*) AS item_count
    FROM order_items
    GROUP BY order_id
) AS order_level_items;

-- How many payment records are associated with each order?
SELECT
    COUNT(*) AS total_payment_records,
    COUNT(DISTINCT order_id) AS orders_with_payment_records,
    MAX(payment_count) AS max_payments_per_order
FROM (
    SELECT
        order_id,
        COUNT(*) AS payment_count
    FROM order_payments
    GROUP BY order_id
) AS order_payments_summary;

-- What is the distribution of payment-record counts per order?
SELECT
    payment_count,
    COUNT(*) AS number_of_orders
FROM (
    SELECT
        order_id,
        COUNT(*) AS payment_count
    FROM order_payments
    GROUP BY order_id
) AS order_payment_counts
GROUP BY payment_count
ORDER BY payment_count;

-- Are there any orders whose customer_id does not exist in customer table?
SELECT
    COUNT(*) AS orphan_orders
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Are there any order_items records referencing
-- product IDs that are missing from the products table?
SELECT
    COUNT(*) AS orphan_order_items
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Are there any order_items records referencing
-- seller IDs that are missing from the sellers table?
SELECT
    COUNT(*) AS orphan_order_items
FROM order_items oi
LEFT JOIN sellers s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;


-- How many unique customers have placed more than one order?
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(DISTINCT o.order_id) > 1
) AS customer_order_summary;

-- Business Question:
-- Which orders have no corresponding records in order_items,
-- and what are the statuses of those orders?
-- Purpose:
-- Validate whether missing order-item records are concentrated
-- in non-completed order statuses.
SELECT
    o.order_status,
    COUNT(*) AS orders_without_items
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL
GROUP BY o.order_status
ORDER BY orders_without_items DESC;

-- Business Question:
-- Which order has no corresponding payment record?
-- Purpose:
-- Identify potential payment-data gaps before using
-- payment_value in revenue or payment analysis.
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp
FROM orders o
LEFT JOIN order_payments op
    ON o.order_id = op.order_id
WHERE op.order_id IS NULL;


-- What is the overall sales performance of the Olist marketplace?
-- Revenue Definition:
--   Product revenue = SUM(order_items.price)
--   Freight revenue = SUM(order_items.freight_value)
--
-- Note:
--   Revenue metrics are calculated from order_items rather than
--   order_payments to avoid payment-record multiplication.
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN o.order_status = 'delivered'
        THEN o.order_id
    END) AS delivered_orders,
    COUNT(oi.order_item_id) AS total_items_sold,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(SUM(oi.freight_value), 2) AS freight_revenue,
    ROUND(
        SUM(oi.price + oi.freight_value)
        / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id;


-- Business Question 1:
-- How has monthly product revenue changed over time?
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
        ROUND(SUM(oi.price), 2) AS monthly_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
)
SELECT
    order_month,
    monthly_revenue
FROM monthly_revenue
ORDER BY order_month;


-- Business Question 2:
-- Which months experienced the strongest revenue growth or decline?
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
        SUM(oi.price) AS monthly_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
),
revenue_with_previous_month AS (
    SELECT
        order_month,
        ROUND(monthly_revenue, 2) AS monthly_revenue,
        LAG(monthly_revenue) OVER (
            ORDER BY order_month
        ) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    order_month,
    monthly_revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        (monthly_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0) * 100,
        2
    ) AS mom_growth_pct
FROM revenue_with_previous_month
ORDER BY order_month;


-- Business Question 3:
-- Which product categories generate the highest revenue?
SELECT
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name
    ) AS category_name,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    COUNT(DISTINCT oi.order_id) AS orders,
    SUM(oi.order_item_id) AS units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pct
    ON p.product_category_name =
       pct.product_category_name
GROUP BY
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name
    )
ORDER BY product_revenue DESC;


-- Business Question 4:
-- Which individual products generate the highest revenue?
SELECT
    oi.product_id,
    COALESCE(
        p.product_category_name,
        'Unknown'
    ) AS category_name,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    COUNT(*) AS units_sold,
    COUNT(DISTINCT oi.order_id) AS orders,
    ROUND(AVG(oi.price), 2) AS average_selling_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    oi.product_id,
    p.product_category_name
ORDER BY product_revenue DESC
LIMIT 20;


-- Business Question 5:
-- What percentage of total product revenue is contributed by each product category?
WITH category_revenue AS (
    SELECT
        COALESCE(
            pct.product_category_name_english,
            p.product_category_name
        ) AS category_name,
        SUM(oi.price) AS category_revenue
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN product_category_translation pct
        ON p.product_category_name =
           pct.product_category_name
    GROUP BY
        COALESCE(
            pct.product_category_name_english,
            p.product_category_name
        )
)
SELECT
    category_name,
    ROUND(category_revenue, 2) AS category_revenue,
    ROUND(
        category_revenue
        / SUM(category_revenue) OVER () * 100,
        2
    ) AS revenue_contribution_pct
FROM category_revenue
ORDER BY category_revenue DESC;


-- Business Question 6:
-- Which categories have high sales volume but relatively low revenue per unit?
SELECT
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name
    ) AS category_name,
    COUNT(*) AS units_sold,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(AVG(oi.price), 2) AS average_selling_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pct
    ON p.product_category_name =
       pct.product_category_name
GROUP BY
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name
    )
HAVING COUNT(*) >= 100
ORDER BY average_selling_price ASC;


-- Business Question 7:
-- How has average order value changed over time?
WITH order_value AS (
    SELECT
        o.order_id,
        DATE_FORMAT(
            o.order_purchase_timestamp,
            '%Y-%m'
        ) AS order_month,
        SUM(oi.price + oi.freight_value) AS order_value
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        o.order_id,
        DATE_FORMAT(
            o.order_purchase_timestamp,
            '%Y-%m'
        )
)
SELECT
    order_month,
    COUNT(*) AS orders,
    ROUND(AVG(order_value), 2) AS average_order_value
FROM order_value
GROUP BY order_month
ORDER BY order_month;


-- Business Question 8:
-- How do payment methods differ in usage and average order value?
WITH order_payments_summary AS (
    SELECT
        order_id,
        MAX(payment_type) AS primary_payment_type,
        SUM(payment_value) AS total_payment_value
    FROM order_payments
    GROUP BY order_id
)
SELECT
    primary_payment_type AS payment_type,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS order_share_pct,
    ROUND(
        AVG(total_payment_value),
        2
    ) AS average_order_value
FROM order_payments_summary
GROUP BY primary_payment_type
ORDER BY orders DESC;


-- Business Question 9:
-- How many customers are one-time buyers versus repeat buyers?
WITH customer_order_frequency AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    CASE
        WHEN order_count = 1
            THEN 'One-time customer'
        ELSE 'Repeat customer'
    END AS customer_type,
    COUNT(*) AS customers,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS customer_share_pct
FROM customer_order_frequency
GROUP BY
    CASE
        WHEN order_count = 1
            THEN 'One-time customer'
        ELSE 'Repeat customer'
    END
ORDER BY customers DESC;


-- Business Question 10:
-- What percentage of Olist customers make more than one purchase?
WITH customer_order_frequency AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN order_count > 1 THEN 1
            ELSE 0
        END
    ) AS repeat_customers,
    ROUND(
        SUM(
            CASE
                WHEN order_count > 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS repeat_purchase_rate_pct
FROM customer_order_frequency;


-- Business Question 11:
-- Which sellers generate the most product revenue?
SELECT
    oi.seller_id,
    COUNT(*) AS units_sold,
    COUNT(DISTINCT oi.order_id) AS orders,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(AVG(oi.price), 2) AS average_selling_price
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY product_revenue DESC
LIMIT 20;


-- Business Question 12:
-- Which sellers generate high revenue despite relatively low sales volume?
WITH seller_metrics AS (
    SELECT
        seller_id,
        COUNT(*) AS units_sold,
        COUNT(DISTINCT order_id) AS orders,
        SUM(price) AS product_revenue,
        AVG(price) AS average_selling_price
    FROM order_items
    GROUP BY seller_id
    HAVING COUNT(*) >= 20
),
seller_quartiles AS (
    SELECT
        seller_id,
        units_sold,
        orders,
        product_revenue,
        average_selling_price,
        NTILE(4) OVER (
            ORDER BY product_revenue DESC
        ) AS revenue_quartile,
        NTILE(4) OVER (
            ORDER BY units_sold ASC
        ) AS volume_quartile
    FROM seller_metrics
)
SELECT
    seller_id,
    units_sold,
    orders,
    ROUND(product_revenue, 2) AS product_revenue,
    ROUND(average_selling_price, 2) AS average_selling_price
FROM seller_quartiles
WHERE revenue_quartile = 1
  AND volume_quartile = 1
ORDER BY product_revenue DESC;


-- Business Question 13:
-- Which seller states have the highest seller productivity?
SELECT
    s.seller_state,
    COUNT(DISTINCT s.seller_id) AS active_sellers,
    COUNT(DISTINCT oi.order_id) AS orders,
    COUNT(*) AS units_sold,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(
        SUM(oi.price)
        / COUNT(DISTINCT s.seller_id),
        2
    ) AS revenue_per_seller,
    ROUND(
        COUNT(DISTINCT oi.order_id)
        / COUNT(DISTINCT s.seller_id),
        2
    ) AS orders_per_seller,
    ROUND(
        COUNT(*)
        / COUNT(DISTINCT s.seller_id),
        2
    ) AS units_per_seller
FROM order_items oi
JOIN sellers s
    ON oi.seller_id = s.seller_id
GROUP BY s.seller_state
HAVING COUNT(DISTINCT s.seller_id) >= 5
ORDER BY revenue_per_seller DESC;


-- Business Question 14:
-- Which product categories generate significant revenue but receive relatively poor customer ratings?
WITH order_review_scores AS (
    SELECT
        order_id,
        AVG(review_score) AS avg_order_review_score
    FROM order_reviews
    WHERE order_id IS NOT NULL
    GROUP BY order_id
),
order_category AS (
    SELECT DISTINCT
        oi.order_id,
        COALESCE(
            pct.product_category_name_english,
            p.product_category_name,
            'unknown'
        ) AS category_name
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN product_category_translation pct
        ON p.product_category_name =
           pct.product_category_name
),
category_reviews AS (
    SELECT
        oc.category_name,
        COUNT(DISTINCT oc.order_id) AS reviewed_orders,
        AVG(ors.avg_order_review_score) AS average_review_score
    FROM order_category oc
    JOIN order_review_scores ors
        ON oc.order_id = ors.order_id
    GROUP BY oc.category_name
),
category_revenue AS (
    SELECT
        COALESCE(
            pct.product_category_name_english,
            p.product_category_name,
            'unknown'
        ) AS category_name,
        SUM(oi.price) AS product_revenue,
        COUNT(DISTINCT oi.order_id) AS orders,
        COUNT(oi.order_item_id) AS units_sold
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN product_category_translation pct
        ON p.product_category_name =
           pct.product_category_name
    GROUP BY
        COALESCE(
            pct.product_category_name_english,
            p.product_category_name,
            'unknown'
        )
)
SELECT
    cr.category_name,
    ROUND(cr.product_revenue, 2) AS product_revenue,
    cr.orders,
    cr.units_sold,
    rr.reviewed_orders,
    ROUND(rr.average_review_score, 2) AS average_review_score
FROM category_revenue cr
LEFT JOIN category_reviews rr
    ON cr.category_name = rr.category_name
WHERE cr.orders >= 100
ORDER BY
    average_review_score ASC;
    
    
-- Business Question 15:
-- Does delivery speed influence repeat purchasing?
WITH delivered_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp,
        DATEDIFF(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp
        ) AS delivery_days,
        ROW_NUMBER() OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp
        ) AS order_rank
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
),
first_orders AS (
    SELECT
        customer_unique_id,
        order_id,
        order_purchase_timestamp AS first_order_date,
        delivery_days
    FROM delivered_orders
    WHERE order_rank = 1
),
repeat_behavior AS (
    SELECT
        f.customer_unique_id,
        f.delivery_days,
        CASE
            WHEN COUNT(o2.order_id) > 0 THEN 1
            ELSE 0
        END AS repeat_within_90_days
    FROM first_orders f
    LEFT JOIN customers c2
        ON f.customer_unique_id = c2.customer_unique_id
    LEFT JOIN orders o2
        ON c2.customer_id = o2.customer_id
       AND o2.order_purchase_timestamp > f.first_order_date
       AND o2.order_purchase_timestamp <=
           DATE_ADD(f.first_order_date, INTERVAL 90 DAY)
    WHERE f.first_order_date <= (
        SELECT DATE_SUB(
            MAX(order_purchase_timestamp),
            INTERVAL 90 DAY
        )
        FROM orders
    )
    GROUP BY
        f.customer_unique_id,
        f.delivery_days
)
SELECT
    CASE
        WHEN delivery_days <= 7 THEN '0-7 days'
        WHEN delivery_days <= 14 THEN '8-14 days'
        WHEN delivery_days <= 21 THEN '15-21 days'
        ELSE '22+ days'
    END AS delivery_group,
    COUNT(*) AS customers,
    SUM(repeat_within_90_days) AS repeat_customers,
    ROUND(
        SUM(repeat_within_90_days) * 100.0
        / COUNT(*),
        2
    ) AS repeat_rate_pct
FROM repeat_behavior
GROUP BY
    CASE
        WHEN delivery_days <= 7 THEN '0-7 days'
        WHEN delivery_days <= 14 THEN '8-14 days'
        WHEN delivery_days <= 21 THEN '15-21 days'
        ELSE '22+ days'
    END
ORDER BY
    MIN(delivery_days);

-- ============================================================
-- Business Question 16:
-- Which customer acquisition months produced the strongest repeat-purchase behavior?
-- Acquisition cohort repeat behavior — exploratory
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp,
        MIN(o.order_purchase_timestamp) OVER (
            PARTITION BY c.customer_unique_id
        ) AS first_order_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
),
customer_cohorts AS (
    SELECT
        customer_unique_id,
        DATE_FORMAT(
            first_order_date,
            '%Y-%m'
        ) AS cohort_month,
        COUNT(*) AS total_orders
    FROM customer_orders
    GROUP BY
        customer_unique_id,
        first_order_date
)
SELECT
    cohort_month,
    COUNT(*) AS customers,
    SUM(
        CASE
            WHEN total_orders > 1 THEN 1
            ELSE 0
        END
    ) AS repeat_customers,
    ROUND(
        SUM(
            CASE
                WHEN total_orders > 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS repeat_rate_pct
FROM customer_cohorts
GROUP BY cohort_month
ORDER BY cohort_month;


-- Business Question 17:
-- What percentage of each customer cohort makes another purchase within 3 months?
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_purchase_timestamp,
        MIN(o.order_purchase_timestamp) OVER (
            PARTITION BY c.customer_unique_id
        ) AS first_order_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
),
cohort_retention AS (
    SELECT
        customer_unique_id,
        first_order_date,
        CASE
            WHEN MAX(
                CASE
                    WHEN order_purchase_timestamp >
                         first_order_date
                     AND order_purchase_timestamp <=
                         DATE_ADD(
                             first_order_date,
                             INTERVAL 90 DAY
                         )
                    THEN 1
                    ELSE 0
                END
            ) = 1
            THEN 1
            ELSE 0
        END AS retained_90_days
    FROM customer_orders
    GROUP BY
        customer_unique_id,
        first_order_date
)
SELECT
    DATE_FORMAT(
        first_order_date,
        '%Y-%m'
    ) AS cohort_month,
    COUNT(*) AS cohort_customers,
    SUM(retained_90_days) AS retained_customers,
    ROUND(
        SUM(retained_90_days) * 100.0
        / COUNT(*),
        2
    ) AS retention_90_day_pct
FROM cohort_retention
GROUP BY
    DATE_FORMAT(
        first_order_date,
        '%Y-%m'
    )
HAVING COUNT(*) >= 100
ORDER BY cohort_month;



-- ============================================================
-- Business Question 18:
-- How does customer retention change month-by-month after the first purchase?
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_purchase_timestamp,
        -- Identify each customer's first purchase
        MIN(o.order_purchase_timestamp) OVER (
            PARTITION BY c.customer_unique_id
        ) AS first_order_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
),
cohort_activity AS (
    SELECT DISTINCT
        customer_unique_id,
        -- Customer acquisition / cohort month
        DATE_FORMAT(
            first_order_date,
            '%Y-%m'
        ) AS cohort_month,
        -- Months elapsed since first purchase
        PERIOD_DIFF(
            DATE_FORMAT(
                order_purchase_timestamp,
                '%Y%m'
            ),
            DATE_FORMAT(
                first_order_date,
                '%Y%m'
            )
        ) AS months_since_first_order
    FROM customer_orders
),
cohort_size AS (
    SELECT
        cohort_month,
        -- Number of customers originally acquired
        COUNT(DISTINCT customer_unique_id) AS cohort_customers
    FROM cohort_activity
    WHERE months_since_first_order = 0
    GROUP BY cohort_month
)
SELECT
    ca.cohort_month,
    ca.months_since_first_order,
    cs.cohort_customers,
    COUNT(DISTINCT ca.customer_unique_id)
        AS retained_customers,
    ROUND(
        COUNT(DISTINCT ca.customer_unique_id)
        * 100.0
        / cs.cohort_customers,
        2
    ) AS retention_pct
FROM cohort_activity ca
JOIN cohort_size cs
    ON ca.cohort_month = cs.cohort_month
GROUP BY
    ca.cohort_month,
    ca.months_since_first_order,
    cs.cohort_customers
ORDER BY
    ca.cohort_month,
    ca.months_since_first_order;
    

-- Business Question 19:
-- How can customers be segmented using RFM analysis?
WITH customer_metrics AS (
    SELECT
        c.customer_unique_id,
        -- Most recent purchase
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        -- Number of distinct orders
        COUNT(DISTINCT o.order_id) AS frequency,
        -- Total product revenue generated
        ROUND(SUM(oi.price), 2) AS monetary
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        c.customer_unique_id
),
rfm_base AS (
    SELECT
        customer_unique_id,
        -- Days since last purchase
        DATEDIFF(
            (
                SELECT MAX(order_purchase_timestamp)
                FROM orders
            ),
            last_purchase_date
        ) AS recency,
        frequency,
        monetary
    FROM customer_metrics
),
rfm_scores AS (
    SELECT
        customer_unique_id,
        recency,
        frequency,
        monetary,
        -- Recent customers receive higher scores
        6 - NTILE(5) OVER (
            ORDER BY recency ASC
        ) AS recency_score,
        -- Frequent customers receive higher scores
        NTILE(5) OVER (
            ORDER BY frequency ASC
        ) AS frequency_score,
        -- Higher spending receives higher scores
        NTILE(5) OVER (
            ORDER BY monetary ASC
        ) AS monetary_score
    FROM rfm_base
)
SELECT
    customer_unique_id,
    recency,
    frequency,
    monetary,
    recency_score,
    frequency_score,
    monetary_score,
    -- Combined RFM score
    recency_score
    + frequency_score
    + monetary_score AS rfm_score,
    CASE
        WHEN recency_score >= 4
         AND frequency_score >= 4
         AND monetary_score >= 4
            THEN 'Champions'
        WHEN recency_score >= 3
         AND frequency_score >= 4
            THEN 'Loyal Customers'
        WHEN recency_score >= 4
         AND frequency_score <= 2
            THEN 'New / Promising'
        WHEN recency_score <= 2
         AND frequency_score >= 3
            THEN 'At Risk'
        WHEN recency_score <= 2
         AND frequency_score <= 2
            THEN 'Lost / Inactive'
        ELSE 'Regular Customers'
    END AS customer_segment
FROM rfm_scores
ORDER BY
    rfm_score DESC;
    

-- Business Question 20:
-- Which RFM customer segments generate the most revenue?
WITH customer_metrics AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(oi.price) AS monetary
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        c.customer_unique_id
),
rfm_scores AS (
    SELECT
        customer_unique_id,
        DATEDIFF(
            (
                SELECT MAX(order_purchase_timestamp)
                FROM orders
                WHERE order_status = 'delivered'
            ),
            last_purchase_date
        ) AS recency,
        frequency,
        monetary,
        6 - NTILE(5) OVER (
            ORDER BY last_purchase_date DESC
        ) AS recency_score,
        NTILE(5) OVER (
            ORDER BY frequency ASC
        ) AS frequency_score,
        NTILE(5) OVER (
            ORDER BY monetary ASC
        ) AS monetary_score
    FROM customer_metrics
),
segmented_customers AS (
    SELECT
        customer_unique_id,
        monetary,
        recency_score,
        frequency_score,
        monetary_score,
        CASE
            WHEN recency_score >= 4
             AND frequency_score >= 4
             AND monetary_score >= 4
                THEN 'Champions'
            WHEN recency_score >= 3
             AND frequency_score >= 4
                THEN 'Loyal Customers'
            WHEN recency_score >= 4
             AND frequency_score <= 2
                THEN 'New / Promising'
            WHEN recency_score <= 2
             AND frequency_score >= 3
                THEN 'At Risk'
            WHEN recency_score <= 2
             AND frequency_score <= 2
                THEN 'Lost / Inactive'
            ELSE 'Regular Customers'
        END AS customer_segment
    FROM rfm_scores
)
SELECT
    customer_segment,
    COUNT(*) AS customers,
    ROUND(
        SUM(monetary),
        2
    ) AS total_revenue,
    ROUND(
        SUM(monetary) * 100.0 /
        SUM(SUM(monetary)) OVER (),
        2
    ) AS revenue_share_pct,
    ROUND(
        AVG(monetary),
        2
    ) AS average_customer_value
FROM segmented_customers
GROUP BY
    customer_segment
ORDER BY
    total_revenue DESC;
    
    
-- Business Question 21:
-- Which RFM segments have the highest customer value?
WITH customer_value AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS customer_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        c.customer_unique_id
)
SELECT
    CASE
        WHEN customer_revenue >= 500 THEN 'High Value'
        WHEN customer_revenue >= 200 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS value_segment,
    COUNT(*) AS customers,
    ROUND(
        SUM(customer_revenue),
        2
    ) AS total_revenue,
    ROUND(
        AVG(customer_revenue),
        2
    ) AS avg_customer_value
FROM customer_value
GROUP BY
    value_segment
ORDER BY
    avg_customer_value DESC;
    

-- Business Question 21:
-- Which customer value segments contribute the most revenue?
WITH customer_value AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS customer_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        c.customer_unique_id
)
SELECT
    CASE
        WHEN customer_revenue >= 500
            THEN 'High Value'
        WHEN customer_revenue >= 200
            THEN 'Medium Value'
        ELSE 'Low Value'
    END AS value_segment,
    COUNT(*) AS customers,
    ROUND(SUM(customer_revenue), 2) AS total_revenue,
    ROUND(AVG(customer_revenue), 2) AS avg_customer_value
FROM customer_value
GROUP BY value_segment
ORDER BY avg_customer_value DESC;


-- Business Question 22:
-- Which customer states generate the most revenue?
SELECT
    c.customer_state,
    COUNT(DISTINCT c.customer_unique_id) AS customers,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT c.customer_unique_id),
        2
    ) AS revenue_per_customer
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    c.customer_state
ORDER BY
    product_revenue DESC;
    

-- Business Question 23:
-- Which product categories generate high revenue but receive relatively low customer ratings?
WITH order_reviews AS (
    SELECT
        order_id,
        AVG(review_score) AS review_score
    FROM order_reviews
    GROUP BY order_id
)
SELECT
    p.product_category_name AS category_name,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    COUNT(DISTINCT oi.order_id) AS orders,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN orders o
    ON oi.order_id = o.order_id
LEFT JOIN order_reviews r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    p.product_category_name
HAVING
    COUNT(DISTINCT oi.order_id) >= 100
ORDER BY
    average_review_score ASC,
    product_revenue DESC;
    

-- Business Question 24:
-- How concentrated is revenue among the top-selling products?
WITH product_revenue AS (
    SELECT
        oi.product_id,
        SUM(oi.price) AS revenue
    FROM order_items oi
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        oi.product_id
),
ranked_products AS (
    SELECT
        product_id,
        revenue,
        RANK() OVER (
            ORDER BY revenue DESC
        ) AS revenue_rank,
        SUM(revenue) OVER () AS total_revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ) AS cumulative_revenue
    FROM product_revenue
)
SELECT
    revenue_rank,
    product_id,
    ROUND(revenue, 2) AS product_revenue,
    ROUND(
        revenue * 100.0 / total_revenue,
        2
    ) AS revenue_share_pct,
    ROUND(
        cumulative_revenue * 100.0 / total_revenue,
        2
    ) AS cumulative_revenue_pct
FROM ranked_products
ORDER BY
    revenue_rank
LIMIT 20;


-- Quality Control Check 1:
-- Establish baseline revenue and order metrics
SELECT
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    COUNT(*) AS delivered_order_items,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(SUM(oi.freight_value), 2) AS freight_revenue,
    ROUND(
        SUM(oi.price + oi.freight_value),
        2
    ) AS total_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';


-- Quality Control Check 2:
-- Validate order_items grain
SELECT
    COUNT(*) AS total_rows,
    COUNT(
        DISTINCT CONCAT(order_id, '-', order_item_id)
    ) AS unique_order_item_keys
FROM order_items;


-- Quality Control Check 3:
-- Validate payment-table grain
SELECT
    payment_count,
    COUNT(*) AS number_of_orders
FROM (
    SELECT
        order_id,
        COUNT(*) AS payment_count
    FROM order_payments
    GROUP BY order_id
) AS payment_summary
GROUP BY payment_count
ORDER BY payment_count;


-- Quality Control Check 4:
-- Detect row multiplication after joining payments
SELECT
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT CONCAT(
        oi.order_id, '-', oi.order_item_id
    )) AS unique_order_items
FROM order_items oi
JOIN order_payments op
    ON oi.order_id = op.order_id;
    
    
-- Quality Control Check 5:
-- Identify orders with items but no payment record
SELECT DISTINCT
    oi.order_id
FROM order_items oi
LEFT JOIN order_payments op
    ON oi.order_id = op.order_id
WHERE op.order_id IS NULL;


-- Quality Control Check 6:
-- Inspect the order with missing payment data
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    COUNT(oi.order_item_id) AS item_count,
    ROUND(SUM(oi.price), 2) AS product_value,
    ROUND(SUM(oi.freight_value), 2) AS freight_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_id = 'bfbd0f9bdef84302105ad712db648a6c'
GROUP BY
    o.order_id,
    o.customer_id,
    o.order_status;
    
    

-- Quality Control Check 7:
-- Validate orders-table grain
SELECT
    order_id,
    COUNT(*) AS row_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Quality Control Check 8:
-- Validate customers-table grain
SELECT
    customer_id,
    COUNT(*) AS row_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- Business Question 25:
-- Which customers generate the highest revenue?
WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        ROUND(SUM(oi.price), 2) AS customer_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    customer_unique_id,
    customer_revenue,
    -- Rank customers from highest to lowest revenue
    RANK() OVER (
        ORDER BY customer_revenue DESC
    ) AS revenue_rank,
    -- Percentage of total customer revenue
    ROUND(
        customer_revenue * 100.0
        / SUM(customer_revenue) OVER (),
        2
    ) AS revenue_share_pct
FROM customer_revenue
ORDER BY customer_revenue DESC
LIMIT 20;



-- Business Question 26:
-- What percentage of revenue comes from the top 1%, 5%, and 10% of customers?
WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS customer_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
ranked_customers AS (
    SELECT
        customer_unique_id,
        customer_revenue,
        ROW_NUMBER() OVER (
            ORDER BY customer_revenue DESC
        ) AS customer_rank,
        COUNT(*) OVER () AS total_customers
    FROM customer_revenue
)
SELECT
    CASE
        WHEN customer_rank <= total_customers * 0.01 THEN 'Top 1%'
        WHEN customer_rank <= total_customers * 0.05 THEN 'Top 5%'
        WHEN customer_rank <= total_customers * 0.10 THEN 'Top 10%'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(SUM(customer_revenue), 2) AS segment_revenue,
    ROUND(
        SUM(customer_revenue) * 100.0 /
        (SELECT SUM(customer_revenue) FROM customer_revenue),
        2
    ) AS cumulative_revenue_share_pct
FROM ranked_customers
WHERE customer_rank <= total_customers * 0.10
GROUP BY
    CASE
        WHEN customer_rank <= total_customers * 0.01 THEN 'Top 1%'
        WHEN customer_rank <= total_customers * 0.05 THEN 'Top 5%'
        WHEN customer_rank <= total_customers * 0.10 THEN 'Top 10%'
    END
ORDER BY
    FIELD(customer_segment, 'Top 1%', 'Top 5%', 'Top 10%');
    

-- Business Question 27:
-- Do frequent customers generate more revenue?
WITH customer_metrics AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count,
        ROUND(SUM(oi.price), 2) AS customer_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time'
        WHEN order_count BETWEEN 2 AND 3 THEN '2-3 orders'
        WHEN order_count BETWEEN 4 AND 5 THEN '4-5 orders'
        ELSE '6+ orders'
    END AS purchase_frequency,
    COUNT(*) AS customers,
    ROUND(AVG(customer_revenue), 2) AS avg_customer_revenue,
    ROUND(SUM(customer_revenue), 2) AS total_revenue
FROM customer_metrics
GROUP BY
    CASE
        WHEN order_count = 1 THEN 'One-time'
        WHEN order_count BETWEEN 2 AND 3 THEN '2-3 orders'
        WHEN order_count BETWEEN 4 AND 5 THEN '4-5 orders'
        ELSE '6+ orders'
    END
ORDER BY avg_customer_revenue DESC;


-- Business Question 28:
-- Do repeat customers place higher-value orders?
WITH customer_order_count AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
order_values AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        SUM(oi.price) AS order_value
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        c.customer_unique_id,
        o.order_id
)
SELECT
    CASE
        WHEN coc.order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS orders,
    ROUND(AVG(ov.order_value), 2) AS average_order_value,
    ROUND(SUM(ov.order_value), 2) AS total_revenue
FROM order_values ov
JOIN customer_order_count coc
    ON ov.customer_unique_id = coc.customer_unique_id
GROUP BY
    CASE
        WHEN coc.order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END;
    

-- Business Question 29:
-- Which RFM customer segments have the highest average order value?
WITH customer_rfm AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(oi.price) AS monetary
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
rfm_segments AS (
    SELECT
        customer_unique_id,
        frequency,
        monetary,
        CASE
            WHEN frequency >= 4 AND monetary >= 500
                THEN 'Champions'
            WHEN frequency >= 2 AND monetary >= 300
                THEN 'Loyal Customers'
            WHEN frequency >= 2
                THEN 'Regular Customers'
            WHEN frequency = 1 AND monetary >= 300
                THEN 'At Risk'
            ELSE 'New / Promising'
        END AS customer_segment
    FROM customer_rfm
),
order_values AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        SUM(oi.price) AS order_value
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        c.customer_unique_id,
        o.order_id
)
SELECT
    r.customer_segment,
    COUNT(ov.order_id) AS orders,
    COUNT(DISTINCT ov.customer_unique_id) AS customers,
    ROUND(AVG(ov.order_value), 2) AS average_order_value,
    ROUND(SUM(ov.order_value), 2) AS total_revenue
FROM rfm_segments r
JOIN order_values ov
    ON r.customer_unique_id = ov.customer_unique_id
GROUP BY r.customer_segment
ORDER BY average_order_value DESC;


-- Business Question 30:
-- Which customer segments contribute the most overall revenue?
WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS customer_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
customer_segments AS (
    SELECT
        customer_unique_id,
        customer_revenue,
        CASE
            WHEN customer_revenue >= 500 THEN 'High Value'
            WHEN customer_revenue >= 200 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS value_segment
    FROM customer_revenue
)
SELECT
    value_segment,
    COUNT(*) AS customers,
    ROUND(SUM(customer_revenue), 2) AS total_revenue,
    ROUND(
        SUM(customer_revenue)
        / (SELECT SUM(customer_revenue)
           FROM customer_revenue) * 100,
        2
    ) AS revenue_share_pct,
    ROUND(AVG(customer_revenue), 2) AS average_customer_value
FROM customer_segments
GROUP BY value_segment
ORDER BY total_revenue DESC;


SELECT USER(), CURRENT_USER();

SELECT user, host, plugin
FROM mysql.user
WHERE user = 'root';

SHOW VARIABLES LIKE 'require_secure_transport';

CREATE USER 'powerbi'@'127.0.0.1'
IDENTIFIED WITH mysql_native_password BY 'Yashiii@24';

GRANT SELECT ON olist.* TO 'powerbi'@'127.0.0.1';

FLUSH PRIVILEGES;


SELECT *
FROM product_category_translation;

SELECT * FROM orders;

SELECT COUNT(*) FROM customers;

SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM order_items;

SELECT COUNT(*) FROM order_payments;

SELECT COUNT(*) FROM order_reviews;

SELECT * 
FROM order_reviews;

SELECT COUNT(*) FROM products;

SELECT COUNT(*) FROM sellers;

SELECT COUNT(*) FROM product_category_translation;

SELECT COUNT(*) AS total_reviews
FROM order_reviews;

SELECT COUNT(DISTINCT review_id) AS unique_reviews
FROM order_reviews;

SELECT COUNT(*) AS duplicate_review_ids
FROM (
    SELECT review_id
    FROM order_reviews
    GROUP BY review_id
    HAVING COUNT(*) > 1
) AS duplicates;

SELECT MIN(review_record_id) AS min_id,
       MAX(review_record_id) AS max_id,
       COUNT(*) AS total
FROM order_reviews;

SELECT COUNT(*) AS rows_with_newlines
FROM order_reviews
WHERE review_comment_title LIKE CONCAT('%', CHAR(10), '%')
   OR review_comment_message LIKE CONCAT('%', CHAR(10), '%');
   
SELECT COUNT(*) AS rows_with_carriage_returns
FROM order_reviews
WHERE review_comment_title LIKE CONCAT('%', CHAR(13), '%')
   OR review_comment_message LIKE CONCAT('%', CHAR(13), '%');
   
SELECT
    review_record_id,
    review_id,
    order_id,
    review_score,
    REPLACE(REPLACE(review_comment_title, CHAR(13), ' '), CHAR(10), ' ') AS review_comment_title,
    REPLACE(REPLACE(review_comment_message, CHAR(13), ' '), CHAR(10), ' ') AS review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM order_reviews;

SELECT COUNT(*) AS total_reviews
FROM (
    SELECT
        review_record_id,
        review_id,
        order_id,
        review_score,
        REPLACE(REPLACE(review_comment_title, CHAR(13), ' '), CHAR(10), ' ') AS review_comment_title,
        REPLACE(REPLACE(review_comment_message, CHAR(13), ' '), CHAR(10), ' ') AS review_comment_message,
        review_creation_date,
        review_answer_timestamp
    FROM order_reviews
) AS cleaned_reviews;

SELECT
    MAX(CHAR_LENGTH(review_comment_title)) AS max_title_length,
    MAX(CHAR_LENGTH(review_comment_message)) AS max_message_length
FROM order_reviews;

SELECT COUNT(*) AS oversized_reviews
FROM order_reviews
WHERE CHAR_LENGTH(review_comment_title) > 32767
   OR CHAR_LENGTH(review_comment_message) > 32767;
   
SHOW CREATE TABLE order_reviews;

SHOW FULL COLUMNS FROM order_reviews;