import psycopg2
import psycopg2.extras as extras
import pandas as pd
import redshift_connector
import csv
import time
import sys
from sqlalchemy import create_engine
sys.path.append('project/config')
sys.path.append('project/sql')
sys.path.append('project/data')
import db_config as dbc

def dbConnection():
    print( "Using psycopg2:" )
    # myConnection = psycopg2.connect( host=dbc.hostname, user=dbc.username, password=dbc.password, dbname=dbc.database )
    # myConnection.autocommit = False
    myConnection = psycopg2.connect( host=dbc.aws_endpoint, port = dbc.aws_port,  user=dbc.aws_username, password=dbc.aws_password, dbname=dbc.aws_database )
    return myConnection


def alchmeyEngine():
    return create_engine("postgresql+psycopg2://{user}:{pw}@localhost/{db}"
                            .format(user=dbc.username,
                                    pw=dbc.pw_alchmey,
                                    db=dbc.database))


def createTable(sql_path):
    # create a connection
    conn = dbConnection()

    # create a cursor
    cur = conn.cursor()

    # read the SQL file and execute query
    with open(sql_path) as f:
        cur.execute(f.read())

    # Commit the changes to the database
    conn.commit()

    # Close the cursor and connection
    cur.close()
    conn.close()

def doQuery(sql_path,output_file_path):
     # create a connection
    conn = dbConnection()

    # create a cursor
    cur = conn.cursor()

    # read the SQL file and execute query
    with open(sql_path) as f:
        cur.execute(f.read())

    # Fetch the results
    results = cur.fetchall()

    columns = [desc[0] for desc in cur.description]

    # Close the cursor and connection
    cur.close()
    conn.close()

    # Generate a timestamp
    timestamp = time.strftime("%Y%m%d%H%M%S")

    # Open the .csv file
    file_name = 'output_{}.csv'.format(timestamp)


    # Open the .csv file
    file_name = 'output_{}.csv'.format(timestamp)
    with open(output_file_path + '/' + file_name, 'w', newline='') as f:
        # Create a csv writer object
        writer = csv.writer(f)
        
        # Write the column names to the .csv file
        writer.writerow(columns)
        
        # Write the results to the .csv file
        writer.writerows(results)


    # with open(output_file_path + '/' + file_name, 'w', newline='') as f:
    #     # Create a csv writer object
    #     writer = csv.writer(f)
        
    #     # Write the results to the .csv file
    #     writer.writerows(results)

def loadData(table_name,schema_name,csv_file):
     # Connect to the database
    engine = alchmeyEngine()

    # Load the .csv file into a pandas dataframe
    df = pd.read_csv(csv_file)

    # Write the dataframe to the database table
    df.to_sql(table_name, engine, schema = schema_name, if_exists='replace')
    

def check_null_values(df):
    if df.isnull().values.any():
        print('Null value found in ')
    else:
        print('No null value found ')

# This function compares the number of records for the given tables (dataframe)
def compare_record_count(db_one, db_two):

    if len(db_one.index) == len(db_two.index):
        print('Contains the same number of records') 
    else:
        print('Conflicting number of records')

# This function reads the data from SQL database and returns it as 
# pandas dataframe
def doExtract(sql_query):
    conn = dbConnection()
    cursor = conn.cursor()
    cursor.execute(sql_query)
    columns = [desc[0] for desc in cursor.description]
    rows = cursor.fetchall()
    df = pd.DataFrame(rows, columns=columns)
    cursor.close()
    conn.close()
    return df
