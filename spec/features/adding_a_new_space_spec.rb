# frozen_string_literal: true

require 'auth_helper'

feature 'Adding a new Space' do
  scenario 'User can add a new space' do
    User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')

  visit '/'
  click_button 'Sign In'
  fill_in(:email_address_si, with: 'test@example.com')
  fill_in(:password_si, with: 'password123')
  click_button('Enter')

    click_link('New Space')
    fill_in('listing-name', with: 'Hertfordshire Hideaway')
    fill_in('listing-description', with: 'It is pretty hidden')
    fill_in('listing-price', with: '75')
    fill_in('listing-fromdate', with: '2021-10-21')
    fill_in('listing-todate', with: '2021-10-30')
    click_button('List my Space')
    expect(page).to have_content('Hertfordshire Hideaway')
    expect(page).to have_content('It is pretty hidden')
    expect(page).to have_content('$75.00')
    # expect(page).to have_content('21/10/2021')
    # expect(page).to have_content('30/10/2021')
  end
end
