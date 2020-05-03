#!/usr/bin/env python
import sys
import requests  # pip install requests
from bs4 import BeautifulSoup  # pip install beautifulsoup

print(' '.join([word.text for word in BeautifulSoup(requests.get(f'https://sinonimos.woxikon.com.br/pt/{sys.argv[1]}').text, 'html.parser').select('.upper-synonyms>a')]))

