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
URLlist = ["Horizon-Organic-Whole-Milk-8-fl-oz-12-count/819219798"
	, "Natural-Egg-Carton-4-Pkg-6-Cavity/715533205"
	, "Pillsbury-All-Purpose-Flour-10-Pound/10308170"
	, "Imperial-Dragon-Jasmine-Rice-20-lbs/12442805"
	, "All-Natural-93-Lean-7-Fat-Lean-Ground-Beef-Tray-1-lb/824841960"
	, "Tyson-Trimmed-Ready-Fresh-Boneless-Skinless-Chicken-Breast-Portions-1-2-2-5-lb/25294832"
	, "President-Imported-Unsalted-Butter-7oz-199g/196693597"
	, "2-pack-Morton-Iodized-Table-Salt-26-Oz/467378637"
	, "McCormick-Pure-Ground-Black-Pepper-Value-Size-6-oz/44981962"
	, "Great-Value-Vegetable-Oil-1-gal/10451011"
	, "Sam-s-Choice-Italia-Enriched-Spaghetti-17-6-oz/328788938"
	, "Simply-Organic-Parsley-Flakes-Cut-and-Sifted-Certified-Organic-0-26-oz-bottle/28646092"
	, "McCormick-Classic-Garlic-Powder-3-12-oz/10535033"
	, "2-Pack-Cento-San-Marzano-Peeled-Tomatoes-28-Oz/143391742"
	, "Great-Value-Ultra-Pasteurized-Real-Heavy-Whipping-Cream-32-Oz/10450340"]
productList = ["milk", "egg", "flour", "rice", "groundbeef", "chicken", "butter", "salt", "pepper", "vegetableoil", "spaghetti", "parsley", "garlic", "tomato", "cream"]#]#,]

productDict = {}

priceList = []

# item_and_price = []

delay = 14

timeout = 15

URLind = 0

driver = webdriver.Chrome('/Users/carson/Downloads/chromedriver')

element_present = EC.presence_of_element_located((By.ID, 'price'))

for product in productList:
	driver.get("https://www.walmart.com/ip/" + URLlist[URLind])

	# try:
	WebDriverWait(driver, timeout).until(element_present)
	# except TimeoutExceptionim:
		# print("Timed out waiting for page to load")
		# driver.quit()

	priceChar = driver.find_element_by_class_name('price-characteristic')

	priceMant = driver.find_element_by_class_name('price-mantissa')

	price = priceChar.text + "." + priceMant.text

	priceList.append(price)

	productDict[productList[URLind]] = price

	# add_to_array = {
	# 	"item_name": product,
	# 	"walmart_price": price
	# }

	# item_and_price.append(add_to_array)

	post_up = {
		"item_name": product,
		"walmart_price": price
	}

	r = requests.post(url='https://4y41287l84.execute-api.us-west-1.amazonaws.com/test1/scrapeitem', data=json.dumps(post_up))
	print(r)

	URLind += 1




# for price in priceList:
# 	print(price)

# for p in productDict:
# 	print (p)
# 	print (productDict[p])

# print(item_and_price)

driver.quit()
