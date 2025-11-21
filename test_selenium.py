import pytest
from selenium.webdriver import Chrome
from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webdriver import WebDriver
#from time import sleep


class TestShoppingCart:

    @pytest.fixture
    def web(self):
        driver = Chrome()
        driver.get('https://www.saucedemo.com/')
        driver.find_element(By.CSS_SELECTOR, '[data-test=username]').send_keys('standard_user')
        driver.find_element(By.CSS_SELECTOR, '[data-test=password]').send_keys('secret_sauce')
        driver.find_element(By.CSS_SELECTOR, '[data-test=login-button]').click()
        inventory_page = driver.find_element(By.CSS_SELECTOR, '.inventory_list')
        assert inventory_page.is_displayed() is True
        yield driver
        #sleep(10)
        driver.quit()  # <-- importante cerrar el navegador

    def test_1_should_add_item_to_cart(self, web: WebDriver):
        products_to_add_cart = web.find_elements(By.CSS_SELECTOR, '[data-test^="add-to-cart"]')
        assert len(products_to_add_cart) > 0
        firstProductButton = products_to_add_cart[0]
        firstProductButton.click()
        #sleep(100)
      