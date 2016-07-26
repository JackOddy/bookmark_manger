require 'spec_helper'
require './app/app.rb'

feature 'viewing links' do

  scenario' I can see links I have added on the links page' do
    Link.create(url:'http://isitfridaytoday.herokuapp.com', title: 'is it friday today?')
    visit ('/links')
    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content('is it friday today?')
    end
  end
end
