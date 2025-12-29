-- 1. Total revenue by region
SELECT
    region,
    SUM(quantity * unit_price) AS total_revenue
FROM sales
GROUP BY region;

-- 2. Monthly revenue trend
SELECT
    FORMAT(order_date, 'yyyy-MM') AS month,
    SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY month;

-- 3. Top 5 products by revenue
SELECT TOP 5
    product,
    SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY product
ORDER BY revenue DESC;

-- 4. Average order value per customer
SELECT
    customer_id,
    AVG(quantity * unit_price) AS avg_order_value
FROM sales
GROUP BY customer_id;

-- 5. Category-wise revenue contribution
SELECT
    category,
    SUM(quantity * unit_price) AS revenue,
    ROUND(
        SUM(quantity * unit_price) * 100.0 /
        SUM(SUM(quantity * unit_price)) OVER (),
    2) AS percentage_contribution
FROM sales
GROUP BY category;

-- 6. Running total of revenue
SELECT
    order_date,
    SUM(quantity * unit_price) AS daily_revenue,
    SUM(SUM(quantity * unit_price)) OVER (
        ORDER BY order_date
    ) AS running_total
FROM sales
GROUP BY order_date
ORDER BY order_date;
