require 'open-uri'
require 'nokogiri'
require 'httparty'
require 'byebug'
require 'json'
require 'csv'
require 'selenium-webdriver'
require 'capybara'


Capybara.register_driver :selenium do |app|  
	Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.javascript_driver = :chrome
Capybara.configure do |config|  
	config.default_max_wait_time = 10 # seconds
	config.default_driver = :selenium
end
# Visit

browser = Capybara.current_session
driver = browser.driver.browser

browser.visit 'https://ru.stackoverflow.com/'
browser.has_content? 'Войти'
browser.find_link('Войти').click
browser.fill_in 'Почта', with: '4vi4me4@gmail.com'
browser.fill_in 'Пароль', with: 'password1'

browser.click_button('Войти')


loop do
	sleep(2)
	if driver.execute_script('return document.readyState') == "complete"
		break
	end
end

posts = Array.new
doc = Nokogiri::HTML(driver.page_source);
post_cards = doc.css('.question-summary')
post_cards.each do |post_card|

	title = post_card.css('.question-hyperlink').text
	voice = post_card.css('.votes').text.to_i
	count_answers = post_card.css('.status').text.to_i
	views = post_card.css('.views').text.to_i
	language = post_card.css('.post-tag').text
	time = post_card.css('.started-link').text
	author = post_card.css('.started > a[2]').text

	post = {
		title: title,
    	voice: voice,
    	count_answers: count_answers,
    	views: views,
    	language: language,
    	time: time,
    	author: author
	}
	posts << post

end
	
CSV.open('copy_stackoverflow.csv', 'w', write_headers: true, headers: posts.first.keys) do |csv|
	posts.each do |post|
	  csv << post
	end
end
