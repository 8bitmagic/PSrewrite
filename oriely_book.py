import requests
import bs4
import re
import sys


ASIN =['076245945X','1338099132','1338109065','1524708933']
#'1338099132'
#1627790624
#0545392551
#0800788036
#0545795664
#0425285170
#076245945X
#1419723448
#076245945X
#841215651

def dd_scrape(ASIN):
    
    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}
    url = "https://www.amazon.com/*/dp/%s/ref=sr_1_2?m=A317YISDMRJIZA" % ASIN

    text = []
    price = []
    stock = 0

    response = requests.get(url, headers=headers)

    soup = bs4.BeautifulSoup(response.text, "html.parser")

    fTest = str(soup.findAll('img', attrs={'alt':'Dogs of Amazon'})[2:-3])

    text5 = soup.findAll('span', attrs={'class':'a-size-medium a-color-price'})
    for span in text5:
        a =(span.text)
        if a is not None:
            print('no price - not valid')
           # print(stock)
            price.append('0.00')
           # print(price)
           # text = []
            return price
            sys.exit()

    a1 = soup.findAll('a', attrs={'class':'a-size-mini a-link-normal'}) # sub links
    a2 = soup.findAll('div', attrs={'class':'inlineBlock-display'})
    print (len(a2))

    for span in a2:
        entry = span.text
        #print (entry)
        text.append(entry)

    for a in range(len(a2)):
            Atext = text[a].strip()
            price.append(re.sub('[UsedNewfrom$ ]', '', Atext)[:])
            

            
    #print (url)
    if price is not None:
        stock = 1

    print(stock)
    return price
    
    

    



