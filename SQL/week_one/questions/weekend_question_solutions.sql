-- Part 1
-- 1. show me all the tran_date,tran_ammt and total tansaction ammount per tran_date

SELECT tran_date, tran_ammt,
SUM(tran_ammt) OVER(PARTITION BY tran_date) AS tran_ammt_per_date
FROM cards_ingest.tran_fact;

-- 2. show me all the tran_date,tran_ammt and total tansaction ammount per tran_date and rank of the transaction ammount desc within per tran_date
/* Output:
	 2022-01-01,7145.00,19543.00,1
 	2022-01-01,6125.00,19543.00,2  */
	
WITH salary_rank AS (
  SELECT tran_date, tran_ammt,
	  SUM(tran_ammt) OVER(PARTITION BY tran_date) AS tran_ammt_per_date,
      RANK() OVER(PARTITION BY tran_date ORDER BY tran_ammt DESC ) AS sal_rank
	
  FROM cards_ingest.tran_fact
)
SELECT
  tran_fact.tran_date, tran_fact.tran_ammt, h.tran_ammt_per_date, h.sal_rank
FROM cards_ingest.tran_fact
JOIN salary_rank h
  ON tran_fact.tran_date = h.tran_date
    AND tran_fact.tran_ammt = h.tran_ammt;
	
/* 3. show me all the fields and total tansaction ammount per tran_date and only 2nd rank of the transaction ammount desc within per tran_date
 (Here you are using he question2 but filtering only for rank 2) */

WITH salary_rank AS (
  SELECT tran_id, tran_date, tran_ammt, 
	  SUM(tran_ammt) OVER(PARTITION BY tran_date) AS tran_ammt_per_date,
      RANK() OVER(PARTITION BY tran_date ORDER BY tran_ammt DESC ) AS sal_rank
	
  FROM cards_ingest.tran_fact
)

SELECT
   tran_fact.*, h.tran_ammt_per_date
FROM cards_ingest.tran_fact
JOIN salary_rank h
  ON tran_fact.tran_date = h.tran_date
    AND tran_fact.tran_ammt = h.tran_ammt
	AND tran_fact.tran_id = h.tran_id
	WHERE h.sal_rank = 2;


--Part 2

-- 1. Join tran_fact and cust_dim_details on cust_id and tran_dt between start_date and end_date
SELECT cust_dim_details.*, tran_fact.tran_id, tran_fact.tran_ammt, tran_fact.tran_date
FROM cards_ingest.cust_dim_details
LEFT JOIN cards_ingest.tran_fact 
ON cust_dim_details.cust_id = tran_fact.cust_id
WHERE tran_date BETWEEN start_date AND end_date;

/* 2. show me all the fields and total tansaction ammount per tran_date and only 2nd rank of the transaction
 ammount desc within per tran_date(Here you are using he question2 but filtering only for rank 2) and join
  cust_dim_details on cust_id and tran_dt between start_date and end_date */
  
WITH salary_rank AS (
SELECT *, 
	 SUM(tran_ammt) OVER(PARTITION BY tran_date) AS tran_ammt_per_date,
     RANK() OVER(PARTITION BY tran_date ORDER BY tran_ammt DESC ) AS sal_rank
	
FROM cards_ingest.tran_fact
)
SELECT cust_dim_details.zip_cd, cust_dim_details.cust_first_name, cust_dim_details.cust_last_name, 
cust_dim_details.start_date, cust_dim_details.end_date, cust_dim_details.active_flag, salary_rank.*
FROM cards_ingest.cust_dim_details
LEFT JOIN salary_rank 
ON cust_dim_details.cust_id = salary_rank.cust_id
WHERE tran_date BETWEEN start_date AND end_date AND salary_rank.sal_rank = 2;


/* 3. From question 2 : when stat_cd is not euqal to state_cd then data issues else good data as stae_cd_status
 [Note NUll from left side is not equal NUll from other side  >> means lets sayd NULL value from fact table if compared
 to NULL Value to right table then it should be data issues] */
 
WITH salary_rank AS (
SELECT *, 
	 SUM(tran_ammt) OVER(PARTITION BY tran_date) AS tran_ammt_per_date,
     RANK() OVER(PARTITION BY tran_date ORDER BY tran_ammt DESC ) AS sal_rank
	
FROM cards_ingest.tran_fact
)
SELECT cust_dim_details.zip_cd, cust_dim_details.cust_first_name, cust_dim_details.cust_last_name, 
cust_dim_details.start_date, cust_dim_details.end_date, cust_dim_details.active_flag, salary_rank.*,
CASE
	WHEN  NOT cust_dim_details.state_cd = salary_rank.stat_cd THEN 'Data Issue'
	WHEN cust_dim_details.state_cd IS NULL OR salary_rank.stat_cd IS NULL THEN 'Data Issue'
	ELSE 'Good data'
END AS state_cd_status
FROM cards_ingest.cust_dim_details
LEFT JOIN salary_rank 
ON cust_dim_details.cust_id = salary_rank.cust_id
WHERE tran_date BETWEEN start_date AND end_date AND salary_rank.sal_rank = 2;
