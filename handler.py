from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.chrome.options import Options

import time
import boto3
import json

def scrape(event, context):
    data = price_scrape()
    file_name = "prices"
    # save_file_to_s3('safeway_prices', file_name, data)

def price_scrape():
    zipcode = "94611"
    searchstring = "milk"

    delay = 5

    timeout = 6

    URL = "https://www.safeway.com/shop/search-results.html?q=" + searchstring + "&zipcode=" + zipcode
    
    options = Options()
    options.binary_location = '/opt/headless-chromium'
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--single-process')
    options.add_argument('--disable-dev-shm-usage')

    driver = webdriver.Chrome('/opt/chromedriver',chrome_options=options)

    driver.get(URL)

    html1 = driver.page_source

    html2 = driver.execute_script("return document.documentElement.innerHTML;")

    element_present = EC.presence_of_element_located((By.ID, 'search-grid_0'))
    WebDriverWait(driver, timeout).until(element_present)

    prices = driver.find_elements_by_class_name('product-price ')
    titles = driver.find_elements_by_class_name('product-title')

    cheapest = 1000000.0
    cheapeststring = ""
    cheapindex = 0
    i = 0


    for i, a in enumerate(prices):
        if float(a.text[12:16]) < cheapest:
            cheapest = float(a.text[12:16])
            cheapindex = i
    cheapeststring = prices[cheapindex].text[11:16]

    body = "Headless Chrome Initialized, Page title:" + driver.title

    driver.close();
    driver.quit();

    response = {
        "statusCode": 200,
        'price': cheapest,
        'name': cheapeststring
    }

    return cheapest

# def save_file_to_s3(bucket, file_name, data):
#     s3 = boto3.resource('s3')
#     obj = s3.Object(bucket, file_name)
#     obj.put(Body=json.dumps(data))