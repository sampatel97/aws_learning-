import sys
import pandas as pd
sys.path.append('utils')
import config
import s3_commands

cred = config.get_config()
bucket_address = cred['redshift']['S3URL']
iam_role = cred['redshift']['IAMROLE']

# print(bucket_address)
# print(iam_role)

# unload ('select * from cards_ingest.order_tran_details_vw')
# to 's3://mybucket/unload/' 
# iam_role 'arn:aws:iam::0123456789012:role/MyRedshiftRole'
# CSV DELIMITER AS '|';

# sql_query = "UNLOAD ('SELECT * FROM cards_ingest.order_tran_details_vw') to '{}' IAM_ROLE '{}' DELIMITER ',' NULL AS 'NULL'HEADER CSV  allowoverwrite parallel off;".format(bucket_address,iam_role)


#Use copy command  to load data into redshift
# data_query.command_to_redshift(sql_query)

delimiter = '|'
# function definiton
# def unload_data(view_name, bucket_address, iam_role, filename, delimiter):
s3_commands.unload_data('cards_ingest.total_brand_profit_vw', bucket_address, iam_role, "cards_ingest.total_brand_profit_vw.csv", delimiter)