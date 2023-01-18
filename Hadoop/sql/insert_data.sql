INSERT INTO tran_ingest.tran_fact (tran_id, cust_id, tran_date, tran_ammount , tran_type)
VALUES (102020,'CA1001',to_date('2022-02-01','yyyy--mm--dd'),1200,'C'),
(102021,'CA1002',to_date('2022-02-01','yyyy--mm--dd'),700,'C'),
(102022,'CA1003',to_date('2022-02-01','yyyy--mm--dd'),500,'C'),
(102023,'CA1004',to_date('2022-02-02','yyyy--mm--dd'),900,'C'),
(102020,'CA1001',to_date('2022-02-02','yyyy--mm--dd'),200,'D'),
(102029,'CA1001',to_date('2022-02-02','yyyy--mm--dd'),700,'C'),
(102024,'CA1005',to_date('2022-02-03','yyyy--mm--dd'),12200,'C'),
(102025,'CA1003',to_date('2022-02-03','yyyy--mm--dd'),200,'D'),
(102026,'CA1004',to_date('2022-02-04','yyyy--mm--dd'),12200,'C'),
(102027,'CA1007',to_date('2022-02-04','yyyy--mm--dd'),9200,'C'),
(102028,'CA1007',to_date('2022-02-04','yyyy--mm--dd'),3200,'D');