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

fieldnames = ['id','cast', 'cinematographer','costume department','director','editor','genres','language','rating','producer','writer','distributor']
fieldNamesMultiple = []

#find which ones are of which type
movie = ia.get_movie('0111161')
for field in fieldnames : 
    if(type(movie.get(field))is list):
        for i in range(1,5):
            fieldNamesMultiple.append(field+"-"+str(i))
    else:
        fieldNamesMultiple.append(field)



def storeMovieData(id) : 
    movie = ia.get_movie(id)
    print("here2")

    with open('imdb3.csv', 'a') as csvfile:
        dataMap = dict((field,"null") for field in fieldNamesMultiple)
        writer = csv.DictWriter(csvfile, fieldnames=fieldNamesMultiple)
        if(id=='0111161'):
            writer.writeheader()
        for field in fieldnames : 
            data=movie.get(field)
            if(data is not None):
                if(type(data) is list):
                    #dataMap[field]=data[0]
                    for i in range(0,min(4,len(data))):
                        dataMap[field+"-"+str(i+1)]=data[i]
                else:
                    dataMap[field]=data

        #writer.writerow({'id': id, 'cast' : dataMap['cast'], 'cinematographer' : dataMap['cinematographer'],'costume department' :dataMap['costume department'],'director' :dataMap['director'],'editor' : dataMap['editor'],'genres' : dataMap['genres'],'language' : dataMap['language'],'rating' :dataMap['rating'],'producer' : dataMap['producer'],'writer' : dataMap['writer'],'distributor' : dataMap['distributor']})
        #writer.writerow({'id-1': id-1, 'id-2': id-2, 'id-3': id-3, 'id-4': id-4, 'cast-1' : dataMap['cast-1'], 'cast-2' : dataMap['cast-2'], 'cast-3' : dataMap['cast-3'], 'cast-4' : dataMap['cast-4'], 'cinematographer-1' : dataMap['cinematographer-1'], 'cinematographer-2' : dataMap['cinematographer-2'], 'cinematographer-3' : dataMap['cinematographer-3'], 'cinematographer-4' : dataMap['cinematographer-4'], 'costume-1 department' :dataMap['costume department-1'], 'costume-2 department' :dataMap['costume department-2'], 'costume-3 department' :dataMap['costume department-3'], 'costume-4 department' :dataMap['costume department-4'], 'director-1' :dataMap['director-1'], 'director-2' :dataMap['director-2'], 'director-3' :dataMap['director-3'], 'director-4' :dataMap['director-4'], 'editor-1' : dataMap['editor-1'], 'editor-2' : dataMap['editor-2'], 'editor-3' : dataMap['editor-3'], 'editor-4' : dataMap['editor-4'], 'genres-1' : dataMap['genres-1'], 'genres-2' : dataMap['genres-2'], 'genres-3' : dataMap['genres-3'], 'genres-4' : dataMap['genres-4'], 'language-1' : dataMap['language-1'], 'language-2' : dataMap['language-2'], 'language-3' : dataMap['language-3'], 'language-4' : dataMap['language-4'], 'rating-1' :dataMap['rating-1'], 'rating-2' :dataMap['rating-2'], 'rating-3' :dataMap['rating-3'], 'rating-4' :dataMap['rating-4'], 'producer-1' : dataMap['producer-1'], 'producer-2' : dataMap['producer-2'], 'producer-3' : dataMap['producer-3'], 'producer-4' : dataMap['producer-4'], 'writer-1' : dataMap['writer-1'], 'writer-2' : dataMap['writer-2'], 'writer-3' : dataMap['writer-3'], 'writer-4' : dataMap['writer-4'], 'distributor-1' : dataMap['distributor-1'], 'distributor-2' : dataMap['distributor-2'], 'distributor-3' : dataMap['distributor-3'], 'distributor-4' : dataMap['distributor-4']})

        writer.writerow({'id': id, \
        'cast-1' : dataMap['cast-1'], 'cast-2' : dataMap['cast-2'], 'cast-3' : dataMap['cast-3'], 'cast-4' : dataMap['cast-4'], \
        'cinematographer-1' : dataMap['cinematographer-1'], 'cinematographer-2' : dataMap['cinematographer-2'], 'cinematographer-3' : dataMap['cinematographer-3'], 'cinematographer-4' : dataMap['cinematographer-4'], \
        'costume department-1' :dataMap['costume department-1'], 'costume department-2' :dataMap['costume department-2'], 'costume department-3' :dataMap['costume department-3'], 'costume department-4' :dataMap['costume department-4'], \
        'director-1' :dataMap['director-1'], 'director-2' :dataMap['director-2'], 'director-3' :dataMap['director-3'], 'director-4' :dataMap['director-4'], \
        'editor-1' : dataMap['editor-1'], 'editor-2' : dataMap['editor-2'], 'editor-3' : dataMap['editor-3'], 'editor-4' : dataMap['editor-4'], \
        'genres-1' : dataMap['genres-1'], 'genres-2' : dataMap['genres-2'], 'genres-3' : dataMap['genres-3'], 'genres-4' : dataMap['genres-4'], \
        'language-1' : dataMap['language-1'], 'language-2' : dataMap['language-2'], 'language-3' : dataMap['language-3'], 'language-4' : dataMap['language-4'], \
        'rating' :dataMap['rating'] ,\
        'producer-1' : dataMap['producer-1'], 'producer-2' : dataMap['producer-2'], 'producer-3' : dataMap['producer-3'], 'producer-4' : dataMap['producer-4'], \
        'writer-1' : dataMap['writer-1'], 'writer-2' : dataMap['writer-2'], 'writer-3' : dataMap['writer-3'], 'writer-4' : dataMap['writer-4'], \
        'distributor-1' : dataMap['distributor-1'], 'distributor-2' : dataMap['distributor-2'], 'distributor-3' : dataMap['distributor-3'], 'distributor-4' : dataMap['distributor-4']})
    return    


f = open(sys.argv[1], 'rb') # opens the csv file
try:
    reader = csv.reader(f)  # creates the reader object
    for row in reader:   # iterates the rows of the file in orders
       # print row    # prints each row
    	id =  ''.join(row)
    	#movie = ia.get_movie(id)
        #print(id)
       # storeMovieData(id,movie)

finally:
    f.close()      # closing

class myThread (threading.Thread):
    def __init__(self, id):
        threading.Thread.__init__(self)
        self.id = id
    def run(self):
        storeMovieData(id)
        




