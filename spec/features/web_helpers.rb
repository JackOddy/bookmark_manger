def sign_in(email:, password:)
  visit '/sessions/new'
    fill_in :email, with: email
    fill_in :pwd, with: password
    click_button 'Sign in'
end

def sign_out
  visit '/links'
  click_button 'Sign out'
end
