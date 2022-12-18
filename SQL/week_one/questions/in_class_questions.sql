
-- 1. Calculate total tran_ammt (sum) for each state

SELECT stat_cd, SUM(tran_ammt) AS total_state_transaction
FROM cards_ingest.tran_fact
GROUP BY stat_cd;

-- 2. Calculate maximum and minimum tran_ammt on each state and tran_date

SELECT stat_cd, tran_date, MAX(tran_ammt) AS max_tran, MIN(tran_ammt) AS min_tran
FROM cards_ingest.tran_fact
GROUP BY stat_cd, tran_date;

-- 3. Calculate total transaction which have tran_ammt more than 10000

SELECT COUNT(*) AS no_of_tran
FROM cards_ingest.tran_fact
WHERE tran_ammt > 10000;

-- 4. Show the state which have total (sum) tran_ammt more than 10000

SELECT stat_cd, SUM(tran_ammt)
FROM cards_ingest.tran_fact
WHERE tran_ammt > 10000
GROUP BY stat_cd;

-- 5. show me the states where total ammt is more than 10000
-- 6. show me the states where cust_id ='cust_104' and  total ammt is more than 10000

SELECT  stat_cd, SUM(tran_ammt) AS state_transaction
FROM cards_ingest.tran_fact
WHERE cust_id = 'cust_104'
GROUP BY stat_cd
HAVING SUM(tran_ammt) > 10000; 

-- 7. Calculate total transaction by state [ if state if NULL make it TX] where total transaction is more than 10000

SELECT COALESCE(stat_cd,'TX'), sum(tran_ammt) as total
FROM cards_ingest.tran_fact
group by COALESCE(stat_cd,'TX')
HAVING SUM(tran_ammt)>10000;

-- 8. Show me a message col if state is null then "missing data" else "good data"

SELECT *,
CASE 
	WHEN stat_cd IS NULL THEN 'missing data'
	ELSE 'good data'
END AS data_status 
FROM cards_ingest.tran_fact; 

-- 9. Show me sum of tran_ammt by state [ if state is null and cust_id='cust_104' then 'TX' else 'CA']

SELECT state_cd, SUM(tran_ammt) AS tot_ammt FROM (
SELECT 
	CASE
		WHEN cust_id = 'cust_104' THEN COALESCE(stat_cd,'TX') 
		ELSE COALESCE(stat_cd,'CA')
	END AS state_cd, tran_ammt
FROM cards_ingest.tran_fact) inq
GROUP BY state_cd;

-- Join Question:

-- 1.Give me all details from transaction table and zip_cd from dimension table.

SELECT t1.*, t2.zip_cd
FROM cards_ingest.tran_fact as t1
INNER JOIN cards_ingest.cust_dim_details as t2
ON t1.cust_id = t2.cust_id;

-- 2. Sum of tran_ammt by zip_cd

SELECT zip_cd, SUM(tran_ammt) AS tot_ammt_by_zip FROM(
	SELECT t1.*, t2.zip_cd
	FROM cards_ingest.tran_fact as t1
	INNER JOIN cards_ingest.cust_dim_details as t2
	ON t1.cust_id = t2.cust_id) AS inq
GROUP BY zip_cd;

-- 3. Give me top 5 customer [ (first name+ last name) is customer] by tran_ammt [highest is first] join on cust_id
-- Solution 1:
SELECT t1.*, CONCAT(t2.cust_first_name, ' ', t2.cust_last_name) AS customer
	FROM cards_ingest.tran_fact as t1
	INNER JOIN cards_ingest.cust_dim_details as t2
	ON t1.cust_id = t2.cust_id
WHERE active_flag = 'Y'
ORDER BY tran_ammt DESC
LIMIT 5;

-- Solution 2:

SELECT cust_id, SUM(tran_ammt) AS tot_ammt_by_cust FROM( 
SELECT t1.*, CONCAT(t2.cust_first_name, ' ', t2.cust_last_name) AS customer
	FROM cards_ingest.tran_fact as t1
	INNER JOIN cards_ingest.cust_dim_details as t2
	ON t1.cust_id = t2.cust_id
	WHERE active_flag = 'Y') as inq
GROUP BY cust_id
ORDER BY tot_ammt_by_cust DESC
LIMIT 5;


-- 4. Give me the all cols from tran_fact [ I don't need state_cd is null] first five records [ lower to highest]

SELECT * FROM cards_ingest.tran_fact
WHERE stat_cd IS NOT NULL
ORDER BY tran_ammt ASC
LIMIT 5;

