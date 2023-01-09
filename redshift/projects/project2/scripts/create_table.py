import os
import sys
sys.path.append('project/utils')
#sys.path.append('project/sql')

import helper_functions

helper_functions.createTable('project/sql/create_schema.sql')
helper_functions.createTable('project/sql/ct_lkp_state_details.sql')
helper_functions.createTable('project/sql/ct_tran_fact.sql')