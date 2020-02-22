from selenium import webdriver
import time

zipcode = raw_input("enter a zipcode: ")
searchstring = raw_input("enter a search: ")

URL = "https://www.safeway.com/shop/search-results.html?q=" + searchstring + "&zipcode=" + zipcode

driver = webdriver.Chrome('/home/jlucke/Downloads/chromedriver')

driver.get(URL)

html1 = driver.page_source

html2 = driver.execute_script("return document.documentElement.innerHTML;")

items = driver.find_elements_by_class_name('product-price ')
cheapest = 1000000.0
cheapindex = 0
i = 0


for i, a in enumerate(items):
	if float(a.text[12:16]) < cheapest:
		cheapest = float(a.text[12:16])
		cheapindex = i
	print(a.text[11:16])
print(cheapest)
print(i)