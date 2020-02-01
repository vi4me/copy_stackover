require 'selenium-webdriver'
require 'capybara'
require 'capybara/rspec'
require 'pry'

describe "the signin process" do
  it "say hello" do 
    puts "hello"
  end
end

describe "testing" do
  include Capybara::DSL
  before do
    Capybara.register_driver :selenium do |app|  
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
    
    Capybara.run_server = false
    Capybara.javascript_driver = :chrome
    Capybara.configure do |config|  
      config.default_max_wait_time = 10 # seconds
      config.default_driver = :selenium
    end
  end

  it "check" do
    visit 'https://ru.stackoverflow.com/'
    expect(find('.youarehere')).to have_content 'Главная'
  end

  it "login" do
    visit 'https://ru.stackoverflow.com/'
    click_link 'Войти'
    fill_in 'Почта', with: '4vi4me4@gmail.com'
    fill_in 'Пароль', with: 'password1'
    click_button('Войти')
  end

  it "search" do
    visit 'https://ru.stackoverflow.com/'
    find('.s-input').set('jquery').native.send_keys(:return)
    expect(find('h1')).to have_content 'Вопросы с меткой [jquery]'
  end
  

  it "search_first_title" do
    visit 'https://ru.stackoverflow.com/'
    first_title = all('h3')
    expect(first_title[0]).to have_content 'Как'
  end
end


