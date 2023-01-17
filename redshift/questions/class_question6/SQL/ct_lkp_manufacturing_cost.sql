DROP TABLE IF EXISTS lkp_data.lkp_manufacturing_cost;
CREATE TABLE IF NOT EXISTS lkp_data.lkp_manufacturing_cost(
    product_name VARCHAR(20) ENCODE lzo,
    manufacturingcost DECIMAL(5,2) ENCODE AZ64
);
