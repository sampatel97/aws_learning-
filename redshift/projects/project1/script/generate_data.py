import csv
import random
import pandas as pd
import numpy as np
import sys
from datetime import datetime, timedelta

def random_date(start, end):
  """
  Generate a random date between the start and end dates.
  """
  delta = end - start
  int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
  random_second = random.randrange(int_delta)
  return start + timedelta(seconds=random_second)

def createData(record_count):
  # Define product names by brand
  product_names = {
    'Apple': ['iphone11', 'iphone12', 'iphone13', 'iphoneSE', 'IpadMax', 'IpadMini', 'laptop256', 'Macbook512'],
    'Samsung': ['galaxy10', 'galaxy11', 'galaxy12', 'galaxy13', 'watch320', 'watch340'],
    'Nokia': ['Nk320', 'Nk400', 'Nk500']
  }
  # Set the range of dates
  start_date = '2022-01-01'
  end_date = '2022-03-31'

  # Convert the dates to datetime objects
  start = datetime.strptime(start_date, '%Y-%m-%d')
  end = datetime.strptime(end_date, '%Y-%m-%d')

  # Generate random records
  records = []
#   sales_dates = pd.date_range(start='2022-01-01', end='2022-03-31')
  for i in range(record_count):
    # order_id = random.randint(1, 1000000)
    order_id = np.random.randint(1000000, 10000000)
    brand_name = random.choice(list(product_names.keys()))
    product_name = random.choice(product_names[brand_name])
    sales_amount = round(random.uniform(5, 1000), 2)
    sales_date = random_date(start, end).strftime('%Y-%m-%d')
    records.append([order_id, brand_name, product_name, sales_amount, sales_date])

  # Write the records to a CSV file
  with open('/Users/sampatel/Desktop/Quintrix/Python/redshift/questions/data/order_data_20220401.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(['order_id', 'brand_name', 'product_name', 'sales_amount', 'sales_date'])
    for record in records:
        writer.writerow(record)
  print("Done")

if __name__ == '__main__':
    # Get the number of records to generate from the command line argument
    record_count = int(sys.argv[1])

    # Generate the data
    createData(record_count)
