WITH tran_info AS(
    SELECT tran_fact.*, lkp_state_details.population_cnt, lkp_state_details.potential_customer_cnt
    FROM cards_ingest.tran_fact
    INNER JOIN lkp_data.lkp_state_details ON tran_fact.stat_cd = lkp_state_details.state_cd
)

SELECT tran_date, stat_cd,
       (SELECT COUNT(DISTINCT cust_id) FROM tran_info WHERE stat_cd = t.stat_cd AND tran_date <= t.tran_date) no_of_unique_cust_till_date, (population_cnt - no_of_unique_cust_till_date) num_of_customer_for_promotion
FROM tran_info t
GROUP BY tran_date, stat_cd, population_cnt
ORDER BY stat_cd,tran_date;