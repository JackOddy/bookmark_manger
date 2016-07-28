def no_email_sign_up
  visit '/account/new'
  within ("//div[@id='new account']") do
    fill_in 'pwd', with: 'test'
    fill_in 'pwd_confirmation', with: 'test'
    click_button 'submit'
  end
end

feature 'requires email to sign up' do
  scenario 'I cannot register a new account without a valid email' do
    expect{ no_email_sign_up }.not_to change(User, :count)
  end
end
