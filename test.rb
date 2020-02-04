require 'selenium-webdriver'
require 'capybara'
require 'capybara/rspec'
require 'pry'
require './scraper.rb'

describe "the signin process" do
  it "say hello" do 
    puts "hello"
  end
end

describe "testing" do
  include Capybara::DSL

  it "search" do
    expect(page).to have_css('.question-hyperlink', count: 96)
    find('.s-input').set('jquery').native.send_keys(:return)
    page.should have_content 'Вопросы'
    expect(find('#nav-users')).to have_content 'Участники'
    page.has_selector?('div.votes')
    page.has_xpath?('/users')
    expect(find('h1')).to have_content 'Вопросы с меткой [jquery]'
  end

end


