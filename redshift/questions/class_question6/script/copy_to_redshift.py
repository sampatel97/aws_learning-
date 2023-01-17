import sys
import pandas as pd
sys.path.append('utils')
import config
import redshift

cred = config.get_config()
bucket_address = cred['redshift']['S3URL']
iam_role = cred['redshift']['IAMROLE']

# print(bucket_address)
# print(iam_role)

sql_query = "COPY lkp_data.lkp_manufacturing_cost FROM '{}' IAM_ROLE '{}' DELIMITER ',' IGNOREHEADER 1 CSV;".format(bucket_address,iam_role)

#Use copy command  to load data into redshift
redshift.command_to_redshift(sql_query)