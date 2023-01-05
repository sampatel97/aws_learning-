/*
Question 1
1. Join  cards_ingest.tran_fact with lkp_state_details on state cd. Make sure if any Null Values from fact remove those records
Show me tran_date,state, number of customer per tran_date and state and number of customer company can target for promotion
who are not customer in but still lives in the state (population - number of customer)
*/
WITH tran_info AS(
    SELECT tran_fact.*, lkp_state_details.population_cnt, lkp_state_details.potential_customer_cnt
    FROM cards_ingest.tran_fact
    INNER JOIN lkp_data.lkp_state_details ON tran_fact.stat_cd = lkp_state_details.state_cd
)

SELECT tran_date, stat_cd,population_cnt, COUNT(DISTINCT cust_id) as count_per_date, (population_cnt - count_per_date) as num_of_target_customer
FROM tran_info
GROUP BY tran_date, stat_cd, population_cnt
ORDER BY tran_date, stat_cd;

/*
Question 2
 To reach each remaining potential_customer_cnt cost 5$, then show me the states where company has to spend 2nd high $ amount.
(make sure do potential_customer_cnt -allready customer count to get remaining potential customer count)
*/
WITH tran_info AS(
    SELECT tran_fact.*, lkp_state_details.population_cnt, lkp_state_details.potential_customer_cnt
    FROM cards_ingest.tran_fact
    INNER JOIN lkp_data.lkp_state_details ON tran_fact.stat_cd = lkp_state_details.state_cd
),

remaining_potential_cust_cost AS(
SELECT tran_date, stat_cd,population_cnt, potential_customer_cnt, COUNT(DISTINCT cust_id) as count_per_date, (population_cnt - count_per_date) as num_of_target_customer, ((potential_customer_cnt - count_per_date) * 5) as remaining_potential_cost 
FROM tran_info
GROUP BY tran_date, stat_cd, population_cnt,potential_customer_cnt
ORDER BY tran_date, stat_cd
),

second_highest_state AS
(
SELECT *,
   DENSE_RANK() OVER (ORDER BY remaining_potential_cost Desc) AS Rnk
FROM remaining_potential_cust_cost
)
SELECT *
FROM second_highest_state
WHERE Rnk=2;

/*
Question 3
Join  cards_ingest.tran_fact with lkp_state_details on state cd. Make sure if any Null Values from fact remove those records
Show me tran_date,state, number of customer per tran_date and state and number of customer company can target for promotion
who are not customer in but still lives in the state (population - number of customer)
But the number of customer from transaction table is total number of unique customer till that date .
*/

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

/*
Question 4
Same as question 2. If state cd is NULL  and cust_id is cust_109 then make sure to change to TX  else CA and calculate states where
company has to spend 2nd lowest $ amount from .
*/
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

/*
Question 5
Show me the total number of customer company has , total population and potential_customer_cnt across all the states
*/

WITH tran_info AS(
    SELECT tran_fact.*, lkp_state_details.population_cnt, lkp_state_details.potential_customer_cnt
    FROM cards_ingest.tran_fact
    INNER JOIN lkp_data.lkp_state_details ON tran_fact.stat_cd = lkp_state_details.state_cd
)

SELECT stat_cd, population_cnt, potential_customer_cnt, COUNT(DISTINCT cust_id) AS no_of_cus_per_state
FROM tran_info
GROUP BY stat_cd,population_cnt,potential_customer_cnt;