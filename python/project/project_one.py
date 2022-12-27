# Requirement:
# 1. Connect to sql database using python.
# 2. Create dataframe by selecting all the cards_ingest.tran_fact
# 3. if the any state has NUll , replace it with TX
# 4. Create another col as commison = tran_ammt*.4
# 5. Create another table as cards_ingest.tran_fact with one extra col
# 6. Check if any null value still exists after the change.
# 7. Load Data to the new table.
# 8. Compare the record count from two tables to make sure that same number of records have been loaded.
 
 #!/usr/bin/python

from __future__ import print_function

hostname = 'hostname'
username = 'database username'
password = 'database password'
database = 'database name'
portNumber = 'port number'

import psycopg2
import psycopg2.extras as extras
import pandas as pd
from sqlalchemy import create_engine

def check_null_values(df):
    if df.isnull().values.any():
        print('Null value found in ')
    else:
        print('No null value found ')

# This function reads the data from SQL database and returns it as 
# pandas dataframe
def doExtract(conn, data_query):

    # Read SQL table       
    sql_query = pd.read_sql_query(data_query, conn)

    # Convert SQL to DataFrame
    return pd.DataFrame(sql_query, columns = ['tran_id', 'cust_id', 'stat_cd','tran_ammt','tran_date'])

# This function compares the number of records for the given tables (dataframe)
def compare_record_count(db_one, db_two):

    if len(db_one.index) == len(db_two.index):
        print('Contains the same number of records') 
    else:
        print('Conflicting number of records')

print( "Using psycopg2:" )
myConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname=database )
myConnection.autocommit = False

# Data Extraction 

sql_query = 'SELECT * FROM cards_ingest.tran_fact'
dataFrame = doExtract(myConnection, sql_query)

# Data Transformation 
# Replace states having NULL values with 'TX'
dataFrame['stat_cd'].fillna('TX', inplace=True)

# Calculate commission for each transaction and it to commision

commision = {}
for idx in dataFrame.index:
   commision[idx] = dataFrame['tran_ammt'][idx] * 0.4

# create a copy of dataframe with commission column added

new_df = dataFrame.copy()
new_df['commision'] = commision

# Check if any null value still exists after the change.
check_null_values(new_df)
check_null_values(dataFrame)

# Compare the record count from two tables
compare_record_count(dataFrame, new_df)

# Data Loading

curs = myConnection.cursor()

#Dropping tran_fact table if already exists.
curs.execute("DROP TABLE IF EXISTS cards_ingest.tran_fact")

# Create another table as cards_ingest.tran_fact with one extra col
sql ='''CREATE TABLE cards_ingest.tran_fact(
    tran_id int,
    cust_id varchar(10),
    stat_cd varchar(2),
    tran_ammt decimal(10,2),
    tran_date date,
    commision decimal(10,2)
    )'''
curs.execute(sql)

# commit the changes
myConnection.commit()

# psycopg2
engine = create_engine("postgresql+psycopg2://{user}:{pw}@localhost/{db}"
                       .format(user="username",
                               pw="password",
                               db="database name"))
# Insert whole DataFrame into MySQL
new_df.to_sql('tran_fact', con = engine,schema = 'cards_ingest' ,if_exists = 'append', index=False)

# Compare the record count from two tables to make sure that same number of records have been loaded.
compare_record_count(new_df,doExtract(myConnection, sql_query))

myConnection.close()
