/* 1. Total unique customer per day.*/

SELECT tran_date, COUNT(DISTINCT cust_id) as unique_cust_per_day
FROM tran_ingest.tran_fact
GROUP BY tran_date;


/* 2. Total number of unique customer till date */

SELECT tran_date,
       (SELECT COUNT(DISTINCT cust_id) FROM tran_ingest.tran_fact  WHERE tran_date <= t.tran_date) no_of_unique_cust_till_date
FROM tran_ingest.tran_fact t
GROUP BY tran_date
ORDER BY tran_date;

/* 3. Total transaction amount per customer per day ( if its C then add if D then subtract ) */

SELECT tran_date, cust_id, SUM(CASE tran_type
							  WHEN 'C' THEN tran_ammount
							  ELSE -tran_ammount
							  END) AS tot_tran_ammount
FROM tran_ingest.tran_fact
GROUP BY cust_id, tran_date;

/* 4. Find out duplicate transaction in total. */

SELECT tran_id, cust_id, tran_date, tran_ammount, tran_type, COUNT(*) as record_count
FROM tran_ingest.tran_fact
GROUP BY tran_id, cust_id, tran_date, tran_ammount, tran_type
HAVING COUNT(*) > 1;

/* 5. show the transaction which has debit but never credit before. */

SELECT * FROM tran_ingest.tran_fact
WHERE tran_type = 'D' AND cust_id NOT IN (SELECT cust_id FROM tran_ingest.tran_fact WHERE tran_type = 'C');
