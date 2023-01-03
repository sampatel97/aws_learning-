hostname = 'yourhostname'
username = 'dbusername'
password = 'dbpassword'
database = 'dbname'
portNumber = 'portnumber'

#When constructing a fully formed URL string to pass to create_engine(),
#special characters such as those that may be used in the user and password need to be URL encoded to be parsed correctly..
#This includes the @ sign.

import urllib.parse
pw_alchmey=urllib.parse.quote_plus(password)

