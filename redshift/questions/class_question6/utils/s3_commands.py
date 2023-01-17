import boto3
from db_connection import dbConnection

def view_bucket_contents(bucket_name):
    # Connect to the S3 service
    s3 = boto3.client('s3')

    # List the contents of the specified bucket
    contents = s3.list_objects(Bucket=bucket_name)

    # Print the contents of the bucket
    print("Contents of the bucket:")
    for obj in contents['Contents']:
        print(obj['Key'])



def delete_file(bucket_name, file_name):
    # Connect to the S3 service
    s3 = boto3.client('s3')

    # Delete the specified file
    s3.delete_object(Bucket=bucket_name, Key=file_name)
    print(f"File {file_name} deleted from {bucket_name} bucket successfully.")


def unload_data(view_name, bucket_address, iam_role, filename, delimiter):
    bucket_address = bucket_address + filename
    # Connect to the Redshift cluster
    conn = dbConnection()
    cur = conn.cursor()
    
    # Create the UNLOAD command
    sql_query = f"UNLOAD ('SELECT * FROM {view_name}') TO '{bucket_address}' IAM_ROLE '{iam_role}' DELIMITER '{delimiter}' NULL AS 'NULL'HEADER CSV  allowoverwrite parallel off;"

    # Execute the UNLOAD command
    cur.execute(sql_query)
    conn.commit()

    # Close the connection
    cur.close()
    conn.close()
    print(f"Data from {view_name} view unloaded to {bucket_address} Successfully")