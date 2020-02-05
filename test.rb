require 'selenium-webdriver'
require 'capybara'
require 'capybara/rspec'
require './scraper.rb'

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
   
  it "file" do
    expect(File).to exist("copy_stackoverflow.csv")

    expect { File.open('copy_stackoverflow.csv') }.to_not raise_error(Errno::ENOENT)
  end

  it "write text in file" do
    @buffer = StringIO.new()
    @filename = "copy_stackoverflow.csv"
    @content = "some text"
    allow(File).to receive(:open).with(@filename,'w').and_yield( @buffer )

    # call the function that writes to the file
    File.open(@filename, 'w') {|f| f.write(@content)}

    # reading the buffer and checking its content.
    expect(@buffer.string).to eq(@content)
  end

  it "present content in file" do
    File.read("copy_stackoverflow.csv").should include "title"
  end

end
