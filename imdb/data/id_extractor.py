"""
This script extracts the IDs of around 14000 movies from sorted in the order of the popularity
"""
import urllib2
from BeautifulSoup import BeautifulSoup as BS

for i in range(1,33300,50):
    url = "http://www.imdb.com/search/title?at=0&languages=en%7C1&num_votes=100,&sort=user_rating&start="+str(i)+"&title_type=feature"
    html = urllib2.urlopen(url).read()
    soup = BS(html)
    elem = soup.findAll('span',{'class':'wlb_wrapper'})
    for s in elem:
        print s['data-tconst']
