import pandas as pd
import boto3
import re
from db_connection import dbConnection

def command_to_redshift(query):
    conn = dbConnection()
    cur = conn.cursor()
    cur.execute(query)
    cur.close()
    conn.commit()
    conn.close()
   
def getTable(query):
    conn = dbConnection()
    df = pd.read_sql_query(query, conn)
    conn.commit()
    conn.close()
    return df

def sql_query(file_path):
    # Read the SQL file
    with open(file_path, 'r') as f:
        sql_query = f.read()

    # remove comments
    sql_query = re.sub(r"/\*[^*]*\*+(?:[^*/][^*]*\*+)*/", "", sql_query)

    conn = dbConnection()
    cur = conn.cursor()
    # Execute the query
    cur.execute(sql_query)

    # Close the connection
    cur.close()
    conn.commit()
    conn.close()
    print("SQL Query Executed Successfully")

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
