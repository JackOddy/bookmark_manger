def sign_up(email: 'test@test.com')
  visit '/account/new'
    within ("//div[@id='new account']") do
      fill_in 'email', with: email
      fill_in 'pwd', with: 'test'
      fill_in 'pwd_confirmation', with: 'test'
      click_button 'submit'
    end
end

feature 'email validation' do
  scenario 'I cannot register an account with an email address that is in use' do
    sign_up
    expect { sign_up }.not_to change(User, :count)
    expect(page).to have_content('Email is already taken')
  end
  scenario 'I cannot sign up without an email address' do
    expect { sign_up(email: nil) }.not_to change(User, :count)
    expect(page).to have_content('Email must not be blank')
  end
  scenario 'I cannot sign up with an invalid email address' do
    expect { sign_up(email: "invalid") }.not_to change(User, :count)
    expect(page).to have_content('Email has an invalid format')
  end
end
