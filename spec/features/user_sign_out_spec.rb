feature 'user sign in' do
  let!(:user) do
    User.create(email: 'user@example.com',
                password: 'secretpassword',
                password_confirmation: 'secretpassword')
  end

  scenario 'I can sign into my account' do
    sign_in(email: user.email, password: user.password)
    sign_out
    expect(page).to have_content 'You have signed out'
  end


end
