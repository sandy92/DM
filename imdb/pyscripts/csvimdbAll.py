import csv
from imdb import IMDb
ia = IMDb()

'''print("\nCast\n")
print(movie['cast'][0]) #

print("\nCinematographer\n")
print(movie['cinematographer'][0])

print("\nGenres\n")
print(movie['genres'][0])

print("\nLanguage\n")
print(movie['language'][0])

print("\nRating\n")
print(movie['rating'])

print("\nProducers\n")
print(movie['producer'][0])

print("\nWriters\n")
print(movie['writer'][0])

print("\nEditors\n")
print(movie['editor'][0])

print("\nDirectors\n")
print(movie['director'][0])

print("\nCostume Designers\n")dwd
print(movie['costume department'][0])

print("\nDistributor\n")
print(movie['distributor'][0])'''

import csv     # imports the csv module
import sys      # imports the sys module


def storeMovieData(id,movie) : 
    print("here2")
    with open('imdb.csv', 'a') as csvfile:
        fieldnames = ['id','cast', 'cinematographer','costume department','director','editor','genres','language','rating','producer','writer','distributor']
        dataMap = dict((field,"null") for field in fieldnames)
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        if(id=='0111161'):
            writer.writeheader()
        for field in fieldnames : 
            data=movie.get(field)
            if(data is not None):
                if(type(data) is list):
                    dataMap[field]=data[0]
                else:
                    dataMap[field]=data

        writer.writerow({'id': id, 'cast' : dataMap['cast'], 'cinematographer' : dataMap['cinematographer'],'costume department' :dataMap['costume department'],'director' :dataMap['director'],'editor' : dataMap['editor'],'genres' : dataMap['genres'],'language' : dataMap['language'],'rating' :dataMap['rating'],'producer' : dataMap['producer'],'writer' : dataMap['writer'],'distributor' : dataMap['distributor']})
    return    


f = open(sys.argv[1], 'rb') # opens the csv file
try:
    reader = csv.reader(f)  # creates the reader object
    for row in reader:   # iterates the rows of the file in orders
        print row    # prints each row
    	id =  ''.join(row)
    	movie = ia.get_movie(id)
        print("here1")
        storeMovieData(id,movie)

finally:
    f.close()      # closing



#movie = ia.get_movie('0133093')



#storeMovieData('0133093',movie)