import os
import sys
import pandas as pd
sys.path.append('project/utils')
sys.path.append('project/sql')

import helper_functions

helper_functions.doQuery('project/sql/questions/question_five.sql','project/data/output')
helper_functions.doQuery('project/sql/questions/question_four.sql','project/data/output')
helper_functions.doQuery('project/sql/questions/question_three.sql','project/data/output')
