import sys
sys.path.append('utils')
import redshift

redshift.create_table("lkp_data.lkp_manufacturing_cost", "product_name varchar(20), manufacturingcost decimal(5,2)")
