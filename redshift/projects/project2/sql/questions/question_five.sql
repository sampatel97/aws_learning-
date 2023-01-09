WITH tran_info AS(
    SELECT tran_fact.*, lkp_state_details.population_cnt, lkp_state_details.potential_customer_cnt
    FROM cards_ingest.tran_fact
    INNER JOIN lkp_data.lkp_state_details ON tran_fact.stat_cd = lkp_state_details.state_cd
)

SELECT stat_cd, population_cnt, potential_customer_cnt, COUNT(DISTINCT cust_id) AS no_of_cus_per_state
FROM tran_info
GROUP BY stat_cd,population_cnt,potential_customer_cnt;