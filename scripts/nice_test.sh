#!/ljsku/miniconda3/bin/python

import datetime

start_time = datetime.datetime.now()
print(f"START : {str(start_time)}")
sum = 0

for i in range(1, 5000000):
    sum = sum + i

print(f'SUM : {sum}')

end_time = datetime.datetime.now()
print(f'END : {str(end_time)}')
elapsed_time = end_time - start_time
print(f'Elapsed : {str(elapsed_time)}')
