import csv
import pandas as pd
# from decimal import Decimal

# create a dictionary containing product name and manufactiuring cost as a key-value pair

products = [('iphon11', 220),('iphone12', 250),('iphone13', 290),
            ('iphoneSE', 190), ('IpadMax', 350), ('IpadMini', 250),
            ('laptop256', 800),('Macbook512', 850),('galaxy10', 150),
            ('galaxy11', 180), ('galaxy12', 200), ('galaxy13', 250),
            ('watch320', 150), ('watch340', 170), ('Nk320', 100),
            ('Nk400', 150),('Nk500', 180)]

# Dictionary comprehension: Create a dictionary from the list of products
#products_dict = {product[0]: Decimal(product[1]).quantize(Decimal('0.00')) for product in products}
products_dict = {product[0]: product[1] for product in products}
df = pd.DataFrame.from_dict(products_dict, orient='index', columns=['manufacturing_cost'])
df.index.name = 'product_name'
df.to_csv('data/product_lkp_details.csv',mode='w')
