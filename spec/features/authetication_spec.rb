feature 'authentication' do
  scenario 'a user can sign in' do
    user = User.create(email_address: 'test@example.com', name: 'test guy', password: 'password123')


    visit '/sessions/new'
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'password123')
    click_button('Sign in')

    expect(page).to have_content 'Welcome, test guy'
  end
  scenario 'a user sees an error if they get their email wrong' do
    user = User.create(email_address: 'test@example.com', name: 'test guy', password: 'password123')

    visit '/sessions/new'
    fill_in(:email, with: 'nottherighttestguy@example.com')
    fill_in(:password, with: 'password123')
    click_button('Sign in')

    expect(page).not_to have_content 'Welcome, test guy'
    expect(page).to have_content 'Please check your username or password.'
  end
  scenario 'a user sees an error if they get their password wrong' do
    user = User.create(email_address: 'test@example.com', name: 'test guy', password: 'password123')

    visit '/sessions/new'
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'wrongpassword')
    click_button('Sign in')

    expect(page).not_to have_content 'Welcome, test guy'
    expect(page).to have_content 'Please check your username or password.'
  end
end