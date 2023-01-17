import sys
import pandas as pd
pd.set_option('display.max_columns', None)
sys.path.append('utils')
import data_query
import s3_commands
import redshift
import re

# sql_query = "SELECT * FROM lkp_data.lkp_manufacturing_cost"
# dataFrame = data_query.doQuery(sql_query)
# print(dataFrame)

# sql_query = "CREATE OR REPLACE VIEW cards_ingest.order_tran_details_vw AS SELECT p.*, l.manufacturingcost FROM cards_ingest.product_sales p JOIN lkp_data.lkp_manufacturing_cost l ON p.product_name = l.product_name"
# data_query.command_to_redshift(sql_query)

# sql_query = " SELECT * FROM cards_ingest.order_tran_details_vw"
# print(sql_query)
# dataFrame = data_query.getTable(sql_query)
# print(dataFrame)

# data_query.sql_query('SQL/profit_vw.sql')

# query = " SELECT * FROM cards_ingest.order_profit_group__vw "
# print(query)
# dataFrame = data_query.getTable(query)
# print(dataFrame)

bucket_name = 'redshifty-unload-data'
# file_name = 'transformation/vw_name/cards_ingest.order_tran_details_vw.csvcards_ingest.order_profit_group__vw.csv000'
boto3_commands.view_bucket_contents(bucket_name)
# boto3_commands.delete_file(bucket_name, file_name)

# data_query.sql_query('SQL/brand_profit.sql')

# query = " SELECT * FROM cards_ingest.total_brand_profit_vw"
# print(query)
# dataFrame = data_query.getTable(query)
# print(dataFrame)

# tables = redshift.get_redshift_tables('cards_ingest')
# for table in tables:
#     print(table)

# print("Views:")
# views = redshift.get_redshift_views('cards_ingest')
# for view in views:
#     print(views)