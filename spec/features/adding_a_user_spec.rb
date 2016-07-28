def sign_up
  visit '/account/new'
  fill_in 'email', with: 'test@test.com'
  fill_in 'pwd', with: 'test'
  fill_in 'pwd_confirmation', with: 'test'
  click_button 'submit'
end

feature 'user signup' do
  scenario 'user can register a new account' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('test@test.com')
    expect(User.first.email).to eq('test@test.com')
  end
end
