/*
7. Create a new view by taking all the records where you have profit. Profit is sales amount -manufacturingcost. So add all the fields from order table
and cost from product_cost.
8. Create col as profit_group the values are [ if profit percenatge is more 10% the "Bumper profit", it is 0 to 10% then "Marginal profit"
if it is -5% to 0% then "Loss making" else "Bumper Loss"
*/

CREATE OR REPLACE VIEW cards_ingest.order_profit_group__vw AS 
SELECT *, 
CASE 
    WHEN (profit/sales_amount) > 0.1 THEN 'Bumper profit'
    WHEN (profit/sales_amount) BETWEEN 0 and 0.1 THEN 'Marginal profit'
    WHEN (profit/sales_amount) BETWEEN -0.05 and 0 THEN 'Loss making'
    ELSE 'Bumper Loss'
END AS profit_group
FROM cards_ingest.order_profit_vw;