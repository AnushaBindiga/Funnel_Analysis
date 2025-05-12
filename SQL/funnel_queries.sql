-- 🔹 Basic Funnel Summary
SELECT
  COUNT(*) AS total_sessions,
  SUM(CASE WHEN product_view = 1 THEN 1 ELSE 0 END) AS product_views,
  SUM(CASE WHEN add_to_cart = 1 THEN 1 ELSE 0 END) AS add_to_cart,
  SUM(CASE WHEN purchase = 1 THEN 1 ELSE 0 END) AS purchases
FROM funnel_data;

-- 🔹 Conversion Rate Summary
SELECT
  ROUND(SUM(product_view) * 1.0 / COUNT(*) * 100, 2) AS product_view_rate,
  ROUND(SUM(add_to_cart) * 1.0 / SUM(product_view) * 100, 2) AS cart_conversion_rate,
  ROUND(SUM(purchase) * 1.0 / SUM(add_to_cart) * 100, 2) AS purchase_conversion_rate
FROM funnel_data
WHERE product_view = 1;  -- Prevents division by 0

-- 🔹 Grouped Funnel Performance by Campaign and Channel
SELECT
  campaign_id,
  channel,
  COUNT(*) AS total_sessions,
  SUM(product_view) AS product_views,
  SUM(add_to_cart) AS add_to_cart,
  SUM(purchase) AS purchases,
  ROUND(SUM(product_view) * 1.0 / COUNT(*) * 100, 2) AS view_rate,
  ROUND(SUM(add_to_cart) * 1.0 / SUM(product_view) * 100, 2) AS cart_rate,
  ROUND(SUM(purchase) * 1.0 / SUM(add_to_cart) * 100, 2) AS purchase_rate
FROM funnel_data
GROUP BY campaign_id, channel
ORDER BY purchases DESC
LIMIT 10;
