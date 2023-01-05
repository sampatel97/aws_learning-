DROP TABLE IF EXISTS cards_ingest,tran_fact;

create table cards_ingest.tran_fact(
    tran_id int,
    cust_id varchar(10),
    state_cd varchar(2),
    tran_ammt decimal(10,2),
    tran_date date
);

/*truncate table cards_ingest.tran_fact;*/
INSERT INTO cards_ingest.tran_fact
	(tran_id, cust_id, stat_cd, tran_ammt, tran_date) VALUES
	(102020, 'cust_101', 'NY', 125,to_date('2022-01-01','yyyy-mm-dd')),
	(102021, 'cust_101', 'NY', 5125,to_date('2022-01-01','yyyy-mm-dd')),
	(1020321, 'cust_101', 'NY', 225,to_date('2022-02-01','yyyy-mm-dd')),
	(1020121, 'cust_101', 'NY', 4125,to_date('2022-02-03','yyyy-mm-dd')),
    (1020222, 'cust_102', 'CA', 6125,to_date('2022-01-01','yyyy-mm-dd')),
    (1020223, 'cust_103', 'CA', 7145,to_date('2022-01-01','yyyy-mm-dd')),
    (1023023, 'cust_103', 'CA', 7145,to_date('2022-04-01','yyyy-mm-dd')),
    (1020123, 'cust_103', 'CA', 7145,to_date('2022-03-01','yyyy-mm-dd')),
    (1020223, 'cust_103', 'CA', 7145,to_date('2022-03-02','yyyy-mm-dd')),
    (102024, 'cust_104', 'TX', 1023,to_date('2022-01-01','yyyy-mm-dd')),
    (102025, 'cust_101', 'NY', 670,to_date('2022-01-03','yyyy-mm-dd')),
	(102026, 'cust_101', 'NY', 5235,to_date('2022-01-03','yyyy-mm-dd')),
    (102027, 'cust_102', 'CA', 61255,to_date('2022-01-04','yyyy-mm-dd')),
    (102028, 'cust_103', 'CA', 7345,to_date('2022-01-04','yyyy-mm-dd')),
    (102029, 'cust_104', 'TX', 1023,to_date('2022-01-05','yyyy-mm-dd')),
    (102030, 'cust_109', NULL, 1023,to_date('2022-01-05','yyyy-mm-dd')),
    (102031, 'cust_104',Null, 1023,to_date('2022-01-05','yyyy-mm-dd')),
    (102031, 'cust_107','TX', 4000,to_date('2022-01-05','yyyy-mm-dd')),
    (1022031, 'cust_107','TX', 4000,to_date('2022-02-05','yyyy-mm-dd')),
    (10202231, 'cust_107','TX', 4000,to_date('2022-02-03','yyyy-mm-dd')),
    (1302031, 'cust_107','CA', 7000,to_date('2022-02-05','yyyy-mm-dd')),
    (10202231, 'cust_111','NV', 10000,to_date('2022-02-03','yyyy-mm-dd')),
    (10202231, 'cust_111','NV', 9000,to_date('2022-07-03','yyyy-mm-dd'));

create table lkp_data.lkp_state_details(
    state_cd varchar(2),
    population_cnt decimal(10,2),
    potential_customer_cnt
);

/*truncate table lkp_data.lkp_state_details;*/
INSERT INTO lkp_data.lkp_state_details
	(state_cd, population_cnt, potential_customer_cnt) VALUES
	('NY',200,100),
    ('CA',500,200),
    ('TX',400,300),
    ('NV',100,90),
    ('NJ',200,70),
    ('PA',300,200);