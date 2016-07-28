def sign_up
  visit '/account/new'
  fill_in 'email', with: 'test@test.com'
  fill_in 'user', with: 'username'
  fill_in 'pwd', with: 'test'
  fill_in 'pwd_confirmation', with: 'test'
  click_button 'submit'
end

feature 'Prevents users signing up with email addresses that are taken' do
  scenario 'I cannot register an account with an email address that is in use' do
    sign_up
    expect { sign_up }.not_to change(User, :count)
    expect(page).to have_content('Email is already taken')
  end
end
