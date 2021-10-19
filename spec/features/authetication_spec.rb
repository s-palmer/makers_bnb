require 'auth_helper'

feature 'authentication' do
  scenario 'a user can sign in' do
    log_in_to_site
    expect(page).to have_content 'Welcome, Test Name'
  end

  scenario 'a user sees an error if they get their email wrong' do
   User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')

  visit '/'
  click_button 'Sign In'
  fill_in(:email_address_si, with: 'tes33t@asexample.com')
  fill_in(:password_si, with: 'password123')
  click_button('Enter')

    expect(page).not_to have_content 'Welcome, test guy'
    expect(page).to have_content 'Please check your email or password.'
  end
  
  scenario 'a user sees an error if they get their password wrong' do
    User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')

  visit '/'
  click_button 'Sign In'
  fill_in(:email_address_si, with: 'test@example.com')
  fill_in(:password_si, with: 'passwor3')
  click_button('Enter')

    expect(page).not_to have_content 'Welcome, test guy'
    expect(page).to have_content 'Please check your email or password.'
  end
end