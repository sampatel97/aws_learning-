DROP TABLE IF EXISTS cards_ingest.product_sales;
CREATE TABLE IF NOT EXISTS cards_ingest.product_sales(
    order_id INTEGER ENCODE AZ64,
    brand_name VARCHAR(10) ENCODE ZSTD,
    product_name VARCHAR(10) ENCODE ZSTD,
    sales_amount INTEGER ENCODE AZ64,
    sales_date DATE ENCODE ZSTD
);
