import sys
sys.path.append('utils')
import helper_functions

table_name = 'device_tran_fact'
schema_name = 'cards_ingest'
file_path = 'data/order_data_20220401.csv'
helper_functions.loadData(schema_name, table_name,file_path)