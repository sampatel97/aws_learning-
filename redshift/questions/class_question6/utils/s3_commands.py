import boto3

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


