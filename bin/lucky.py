#!/usr/bin/python
import requests
import sys
from bs4 import BeautifulSoup

search = str(sys.argv)
goo = "https://www.google.com/search?q=" + search

r = requests.get(goo)

soup = BeautifulSoup(r.text, "html.parser")
print soup.find('cite').text
