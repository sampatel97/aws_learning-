import boto3
import sys
sys.path.append('config')
from config import get_config

def unload_data_to_s3(bucket,table_name,s3_key_prefix,file_name):
    config = get_config()
    # Create a boto3 client for Redshift
    redshift = boto3.client('redshift')
    
    # Get the list of S3 buckets
    s3 = boto3.client('s3')
   
    
    # Get schema and table name
    schema, table = table_name.split('.')
    
    # Set the Redshift query to unload data from
    query = f'SELECT * FROM {table_name}'
    
    # Set the IAM role
    iam_role = '{}'.format(config['redshift']['IAMROLE'])
    
    # Unload the data to the S3 bucket
    redshift.execute(f"COPY {table_name} TO 's3://{bucket}/{s3_key_prefix}/{file_name}.csv' CREDENTIALS 'aws_iam_role={iam_role}' DELIMITER ',' NULL AS 'NULL' CSV;")
    print(f"Data from {table_name} has been unloaded to s3://{bucket}/{s3_key_prefix}/{file_name}.csv")