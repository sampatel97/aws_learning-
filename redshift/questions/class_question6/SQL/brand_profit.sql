/*
10. Create another view to show total profit by each brand_name,year-mth cd (ex:202201,202203). Do a rank by the total profit (desc) and
amount of product sold (Asc)
*/

CREATE OR REPLACE VIEW cards_ingest.total_brand_profit_vw AS
SELECT
  brand_name,
  date_trunc('month', sales_date) AS year_mth,
  SUM(profit) AS total_profit,
  COUNT(product_name) AS total_product_sold,
  RANK() OVER (PARTITION BY brand_name, date_trunc('month', sales_date) ORDER BY SUM(profit) DESC, COUNT(product_name) ASC) as rank
FROM cards_ingest.order_profit_group__vw 
GROUP BY brand_name, date_trunc('month', sales_date)