import boto3
from botocore.exceptions import ClientError
# Create a bucket using boto3 and then list the buckets (from the metadata), make sure the bucket exists else fail.

def get_client():
    client = boto3.client('s3')
    return client

def get_bucket_list():
    s3 = get_client()
    # Call S3 to list current buckets
    response = s3.list_buckets()

    # Get a list of all bucket names from the response
    buckets = [bucket['Name'] for bucket in response['Buckets']]
    
    return buckets

def createBucket(bucket_name,region):
    s3 = get_client()
    s3.create_bucket(Bucket=bucket_name,CreateBucketConfiguration={'LocationConstraint': region})
    buckets = get_bucket_list()
    # Check if the bucket exists
    if bucket_name in buckets:
        print(f"Bucket {bucket_name} successfully created.")
        return buckets
    else:
        print(f"Bucket {bucket_name} failed.")
      
    # try:
    #     s3.create_bucket(Bucket=bucket_name,CreateBucketConfiguration={'LocationConstraint': 'us-east-2'})
    #     buckets = get_bucket_list()
    #     # Check if the bucket exists
    #     if bucket_name in buckets:
    #         print(f"Bucket {bucket_name} successfully created.")
    #     else:
    #         print(f"Bucket {bucket_name} failed.")

    # except ClientError as error:
    #     error_code = error.response['Error']['Code']
    #     if error_code == 'BucketAlreadyExists':
    #         print(f"Bucket {bucket_name} already exists.")
    #     elif error_code == 'InvalidBucketName':
    #         print(f"Invalid bucket name {bucket_name}.")
    #     elif error_code == 'AuthorizationHeaderMalformed':
    #         print(f"Authorization header is malformed, please check your credentials.")
    #     else:
    #         print(f"An error occurred: {error}")
   
