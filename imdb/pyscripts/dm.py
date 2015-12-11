from imdb import IMDb
ia = IMDb()

movie = ia.get_movie('0133093')

print("\nCast\n")
print(movie['cast'])

print("\nCinematographer\n")
print(movie['cinematographer'])

print("\nGenres\n")
print(movie['genres'])

print("\nLanguage\n")
print(movie['language'])

print("\nRating\n")
print(movie['rating'])

print("\nProducers\n")
print(movie['producer'])

print("\nWriters\n")
print(movie['writer'])

print("\nEditors\n")
print(movie['editor'])

print("\nDirectors\n")
print(movie['director'])

print("\nCostume Designers\n")
print(movie['costume department'])



