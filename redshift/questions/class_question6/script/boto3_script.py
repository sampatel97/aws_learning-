import sys
sys.path.append('utils')
import create_bucket
import s3_commands

#create_bucket.createBucket('redshifty-unload-data','us-east-2')
buckets = create_bucket.get_bucket_list()
print(buckets)

s3_commands.view_bucket_contents('redshifty-unload-data')