from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException
import time
import requests
import json

#List of predefined ingredients for recipes
#Can be updated to include user submissions
URLlist = ["136010121", "960096423", "117100059", "126150250", "188100176", "960261971", "138250149", "114100007", "960131103", "115150046", "128200289", "184410046", "184390060", "184570136", "136150087"]
productList = ["milk", "egg", "flour", "rice", "groundbeef", "chicken", "butter", "salt", "pepper", "vegetableoil", "spaghetti", "parsley", "garlic", "tomato", "cream"]#,]
# productList = ["milk", "egg", "flour", "rice"]

productDict = {}

# item_and_price = []

priceList = []

delay = 20

timeout = 50

URLind = 0

driver = webdriver.Chrome('/Users/carson/Downloads/chromedriver')

element_present = EC.presence_of_element_located((By.ID, 'product-detail_0'))

for product in productList:
	driver.get("https://www.safeway.com/shop/product-details." + URLlist[URLind] + ".html")

	try:
		WebDriverWait(driver, timeout).until(element_present)
	except TimeoutExceptionim:
		print("Timed out waiting for page to load")

	price = driver.find_element_by_class_name('product-price ')

	priceList.append(price.text[11:16])

	productDict[productList[URLind]] = price.text[11:16]

	# add_to_array = {
	# 	"item_name": product,
	# 	"safeway_price": price
	# }

	post_up = {
		"item_name": product,
		"safeway_price": price.text[12:16]
	}

	# r = requests.post(url='https://4y41287l84.execute-api.us-west-1.amazonaws.com/test1/scrapeitem', data=json.dumps(post_up))
	# print(r)


	# item_and_price.append(add_to_array)

	URLind += 1

# print(item_and_price)


# driver = webdriver.Chrome('/Users/carson/Downloads/chromedriver')

# driver.get("https://www.safeway.com/shop/product-details." + URLlist[URLind] + ".html")

# URLind += 1

# html1 = driver.page_source

# html2 = driver.execute_script("return document.documentElement.innerHTML;")

# priceMilk = driver.find_element_by_class_name('product-price ')

# priceList.append(priceMilk.text[11:16])


# #Scrapper for Egg prices only

# driver.get("https://www.safeway.com/shop/product-details." + URLlist[URLind] + ".html")

# URLind += 1

# element_present = EC.presence_of_element_located((By.ID, 'product-detail_0'))
# WebDriverWait(driver, timeout).until(element_present)

# priceEgg = driver.find_element_by_class_name('product-price ')


# priceList.append(priceEgg.text[11:16])


# #Scrapper for flour

# driver.get("https://www.safeway.com/shop/product-details." + URLlist[URLind] + ".html")

# URLind += 1

# # element_present = EC.presence_of_element_located((By.ID, 'product-detail_0'))
# WebDriverWait(driver, timeout).until(element_present)

# priceFlour = driver.find_element_by_class_name('product-price ')

# priceList.append(priceFlour.text[11:16])


# #Scrapper for rice

# driver.get("https://www.safeway.com/shop/product-details." + URLlist[URLind] + ".html")

# URLind += 1

# # element_present = EC.presence_of_element_located((By.ID, 'product-detail_0'))
# WebDriverWait(driver, timeout).until(element_present)

# priceRice = driver.find_element_by_class_name('product-price ')

# priceList.append(priceRice.text[11:16])


# #Scrapper for groundbeef

# driver.get("https://www.safeway.com/shop/product-details." + URLlist[URLind] + ".html")

# URLind += 1

# # element_present = EC.presence_of_element_located((By.ID, 'product-detail_0'))
# WebDriverWait(driver, timeout).until(element_present)

# priceGroundBeef = driver.find_element_by_class_name('product-price ')

# priceList.append(priceGroundBeef.text[11:16])



for price in priceList:
	print(price)

for p in productDict:
	print (p)
	print (productDict[p])

driver.quit()

