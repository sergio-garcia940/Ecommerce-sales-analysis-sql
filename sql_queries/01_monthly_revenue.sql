--Date formatting and monthly revenue calculation.--
SELECT
  FORMAT_DATE('%Y-%m', DATE(o.order_purchase_timestamp)) AS year_month,
  ROUND(SUM(p.payment_value),2) AS monthly_revenue
FROM `ecommerce_analysis.olist_orders_dataset` o
JOIN `ecommerce_analysis.olist_order_payments_dataset` p
ON o.order_id = p.order_id
GROUP BY year_month
ORDER BY year_month;
