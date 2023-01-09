import os
import sys
sys.path.append('project/utils')
sys.path.append('project/data')
#sys.path.append('project/sql')

import helper_functions

helper_functions.loadData('tran_fact','cards_ingest','project/data/cards_ingest/tran_fact.csv')
helper_functions.loadData('lkp_state_details','lkp_data','project/data/lkp_data/lkp_state_details.csv')