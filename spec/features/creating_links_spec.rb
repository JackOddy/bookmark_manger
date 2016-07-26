require 'spec_helper'
require './app/app.rb'

feature 'viewing links' do

  scenario' I can create a new link' do
    visit ('/links/new')
    fill_in 'url', with: 'rckpprscslzdspk.herokuapp.com'
    fill_in 'title', with: 'Rock Paper Scissors Lizard Spock'
    click_button 'Add Link'

    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_content('Rock Paper Scissors Lizard Spock')
    end
  end
end
