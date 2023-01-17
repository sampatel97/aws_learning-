import sys
sys.path.append('utils')
import redshift

#redshift.create_table("lkp_data.lkp_manufacturing_cost", "product_name varchar(20), manufacturingcost decimal(5,2)")
redshift.sql_query('SQL/ct_cards_ingest.product_sales.sql')
redshift.sql_query('SQL/ct_lkp_manufacturing_cost.sql')