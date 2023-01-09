WITH tran_info AS(
    SELECT myTable.tran_id, myTable.cust_id, myTable.state_cd, myTable.tran_ammt, myTable.tran_date, 
    lkp_state_details.population_cnt, lkp_state_details.potential_customer_cnt
    FROM
    (
        SELECT *,
        CASE
        WHEN cust_id = 'cust_109' THEN COALESCE(stat_cd,'TX')
        ELSE COALESCE(stat_cd,'CA')
        END AS state_cd
        FROM cards_ingest.tran_fact) AS myTable
    INNER JOIN lkp_data.lkp_state_details ON myTable.state_cd = lkp_state_details.state_cd
),

remaining_potential_cust_cost AS(
SELECT tran_date, state_cd,population_cnt, potential_customer_cnt, COUNT(DISTINCT cust_id) as count_per_date, (population_cnt - count_per_date) as num_of_target_customer, ((potential_customer_cnt - count_per_date) * 5) as remaining_potential_cost 
FROM tran_info
GROUP BY tran_date, state_cd, population_cnt,potential_customer_cnt
ORDER BY tran_date, state_cd
),

second_lowest_state AS(
SELECT *,
   DENSE_RANK() OVER (PARTITION BY tran_date ORDER BY remaining_potential_cost ASC) AS Rnk
FROM remaining_potential_cust_cost)

SELECT * FROM second_lowest_state
WHERE Rnk = 2;
