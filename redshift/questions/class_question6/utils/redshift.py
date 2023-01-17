import pandas as pd
import boto3
import re
from db_connection import dbConnection

def get_redshift_tables(schema_name):
    conn = dbConnection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT tablename 
        FROM pg_tables 
        WHERE schemaname = %s
    """,(schema_name,))
    tables = cursor.fetchall()
    cursor.close()
    conn.close()
    return tables

def get_redshift_views(schema_name):
    conn = dbConnection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT viewname 
        FROM pg_views 
        WHERE schemaname = %s
    """,(schema_name,))
    tables = cursor.fetchall()
    cursor.close()
    conn.close()
    return tables

def create_table(schema_tablename,columns):
    conn = dbConnection()
    cur = conn.cursor()
    cur.execute(f"CREATE TABLE IF NOT EXISTS {schema_tablename} ({columns})")
    conn.commit()
    cur.close()
    conn.close()


def get_columns(table_name, schema_name):
    conn = dbConnection()
    cur = conn.cursor()
    cur.execute(f"SELECT column_name FROM information_schema.columns WHERE table_name='{table_name}' AND table_name='{schema_name}")
    columns = [row[0] for row in cur.fetchall()]
    cur.close()
    conn.close()
    return columns


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