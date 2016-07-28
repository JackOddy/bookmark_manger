def sign_in(email:, password:)
  visit '/links'
  within ("//div[@id='sign in']") do
    fill_in :email, with: email
    fill_in :pwd, with: password
    click_button 'Sign in'
  end
end

def sign_out
  visit '/links'
    within ("//div[@id='sign out']") do
      click_button 'Sign out'
  end
end
