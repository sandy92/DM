import sys      # imports the sys module
import csv
import os
import time

f = open(sys.argv[1], 'rb') # opens the csv file

try:
    reader = csv.reader(f)  # creates the reader object
    count = 0
    for row in reader:   # iterates the rows of the file in orders
        count = count + 1
        if count % 12 == 0:
            time.sleep(3)
        if count > 100000:
            f.close()
            break
        print row    # prints each row
    	id =  ''.join(row)
        os.system("nohup python ./sandSc.py " + str(id) + " >> data.csv 2>/dev/null &")
    	#movie = ia.get_movie(id)
        #storeMovieData(id,movie)
finally:
    f.close()      # closing
