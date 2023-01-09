import pandas as pd
from sqlalchemy import create_engine
from urllib.parse import quote_plus
import csv
import sys
sys.path.append('config')
import db_config as dbc

def dbConnection():
    # Encode the password as a URL-safe string
    encoded_password = quote_plus(dbc.password)
    engine = create_engine(f'postgresql://{dbc.username}:{encoded_password}@{dbc.hostname}/{dbc.database}')
    return engine

def loadData(schema_name,table_name,file_path):
    engine = dbConnection()
    # Load the .csv file into a pandas dataframe
    df = pd.read_csv(file_path)

    # Write the dataframe to the database table
    df.to_sql(table_name, engine, schema=schema_name, if_exists='replace',index=False)  