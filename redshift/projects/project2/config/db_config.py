hostname = 'xyz'
username = 'xyz'
password = 'xyz'
database = 'xyz'
portNumber = '1234'

#When constructing a fully formed URL string to pass to create_engine(),
#special characters such as those that may be used in the user and password need to be URL encoded to be parsed correctly..
#This includes the @ sign.

import urllib.parse
pw_alchmey=urllib.parse.quote_plus(password)

aws_username = 'awsuser'
aws_password = 'aws_password'
aws_endpoint = 'redshift-cluster-4.amazonaws.com'
aws_port = 'port_number'
aws_database = 'database name'

engine_url = 'postgresql+psycopg2://{}:{}@{}:{}/{}'.format(aws_username, aws_password, aws_endpoint, aws_port, aws_database)


