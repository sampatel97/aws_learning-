import psycopg2
import psycopg2.extras as extras
import pandas as pd
from sqlalchemy import create_engine
from config import database_credentials as dbc

def dbConnection():
    #print( "Using psycopg2:" )
    myConnection = psycopg2.connect( host=dbc.hostname, user=dbc.username, password=dbc.password, dbname=dbc.database )
    myConnection.autocommit = False
    return myConnection

def alchmeyEngine():
    return create_engine("postgresql+psycopg2://{user}:{pw}@localhost/{db}"
                            .format(user=dbc.username,
                                    pw=dbc.pw_alchmey,
                                    db=dbc.database))

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
def doExtract(conn, data_query):

    # Read SQL table       
    sql_query = pd.read_sql_query(data_query, conn)

    #columns = ['tran_id', 'cust_id', 'stat_cd','tran_ammt','tran_date']

    # Convert SQL to DataFrame
    return pd.DataFrame(sql_query)
