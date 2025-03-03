import csv
from imdb import IMDb
ia = IMDb()
id = '0133093'

movie = ia.get_movie(id)

'''print("\nCast\n")
print(movie['cast'][0])

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

movie.

with open('imdb.csv', 'w') as csvfile:
    fieldnames = ['id','cast', 'cinematographer','costume department','director','editor','genres','language','rating','producer','writer','distributor']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    writer.writeheader()
    writer.writerow({'id': id, 'cast' : movie['cast'][0], 'cinematographer' : movie['cinematographer'][0],'costume department' : movie['costume department'][0],'director' : movie['director'][0],'editor' : movie['editor'][0],'genres' : movie['genres'][0],'language' : movie['language'][0],'rating' : movie['rating'],'producer' : movie['producer'][0],'writer' : movie['writer'][0],'distributor' : movie['distributor'][0]})
    
