--Applying customer categorization logic--
WITH customer_metrics AS (
  SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price + oi.freight_value) AS total_revenue
  FROM `ecommerce_analysis.olist_orders_dataset` o
  JOIN `ecommerce_analysis.olist_order_items_dataset` oi
    ON o.order_id = oi.order_id
  JOIN `ecommerce_analysis.olist_customers_dataset` c
    ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)

SELECT
  customer_unique_id,
  total_orders,
  ROUND(total_revenue,2) AS total_revenue,
  ROUND(total_revenue / total_orders,2) AS avg_order_value,
  RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM customer_metrics
ORDER BY total_revenue DESC
LIMIT 10;
