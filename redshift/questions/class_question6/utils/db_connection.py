import psycopg2
import sys
sys.path.append('config')
from config import get_config

def dbConnection():
    config = get_config()
    conn = psycopg2.connect(host=config['redshift']['host'],
                            user=config['redshift']['user'],
                            password=config['redshift']['password'],
                            dbname=config['redshift']['dbname'],
                            port=config['redshift']['port'])
    return conn

