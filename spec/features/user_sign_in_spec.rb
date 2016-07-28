feature 'user sign in' do
  let!(:user) do
    User.create(email: 'user@example.com',
                password: 'secretpassword',
                password_confirmation: 'secretpassword')
  end

  scenario 'I can sign into my account' do
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content("Welcome, #{user.email}")
  end

  def sign_in(email:, password:)
    visit '/sessions/new'
    fill_in :email, with: email
    fill_in :pwd, with: password
    click_button 'Sign in'
  end
end
