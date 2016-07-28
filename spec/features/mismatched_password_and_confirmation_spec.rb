def bad_sign_up
  visit '/account/new'
  fill_in 'email', with: 'test@test.com'
  fill_in 'user', with: 'silent_ninjaTruck87'
  fill_in 'pwd', with: 'qwertyuiop'
  fill_in 'pwd_confirmation', with: 'testing'
  click_button 'submit'
end

feature 'password confirmation' do
  scenario 'user cannot register if password and confirmation do not match' do
    expect { bad_sign_up }.to change(User, :count).by(0)
    expect(current_path).to eq('/account')
    expect(page).to have_content 'do not match'
  end
end
