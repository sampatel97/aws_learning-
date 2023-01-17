import sys
import pandas as pd
pd.set_option('display.max_columns', None)
sys.path.append('utils')
import s3_commands
import redshift
import re


# redshift.sql_query('SQL/profit_vw.sql')

# query = " SELECT * FROM cards_ingest.order_profit_group__vw "
# print(query)
# dataFrame = redshift.getTable(query)
# print(dataFrame)

bucket_name = 'redshifty-unload-data'
# file_name = 'transformation/vw_name/cards_ingest.order_tran_details_vw.csvcards_ingest.order_profit_group__vw.csv000'
s3_commands.view_bucket_contents(bucket_name)
# s3_commands.delete_file(bucket_name, file_name)

# redshift.sql_query('SQL/brand_profit.sql')

# query = " SELECT * FROM cards_ingest.total_brand_profit_vw"
# print(query)
# dataFrame = redshift.getTable(query)
# print(dataFrame)

# tables = redshift.get_redshift_tables('cards_ingest')
# for table in tables:
#     print(table)

# print("Views:")
# views = redshift.get_redshift_views('cards_ingest')
# for view in views:
#     print(views) 