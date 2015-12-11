from imdb import IMDb
ia = IMDb()

movie = ia.get_movie('0133093')

print("\nCast\n")
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

print("\nCostume Designers\n")
print(movie['costume department'][0])

print("\nDistributor\n")
print(movie['distributor'][0])

