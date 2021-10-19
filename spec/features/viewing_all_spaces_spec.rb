require 'auth_helper'

feature 'Viewing Spaces' do
  scenario 'User should be able to view all available spaces' do
    User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
  visit '/'
  click_button 'Sign In'
  fill_in(:email_address_si, with: 'test@example.com')
  fill_in(:password_si, with: 'password123')
  click_button('Enter')

    click_link('New Space')
    fill_in('listing-name', with: 'Boschtower')
    fill_in('listing-description', with: 'Medieval Nightmare Fuel')
    fill_in('listing-price', with: '45')
    fill_in('listing-fromdate', with: '2021-10-21')
    fill_in('listing-todate', with: '2021-10-30')
    click_button('List my Space')

    click_link('New Space')
    fill_in('listing-name', with: 'XOYO')
    fill_in('listing-description', with: 'YOU WILL NOT SLEEP')
    fill_in('listing-price', with: '14')
    fill_in('listing-fromdate', with: '2021-10-21')
    fill_in('listing-todate', with: '2021-10-30')
    click_button('List my Space')

    click_link('New Space')
    fill_in('listing-name', with: 'Hertfordshire Hideaway')
    fill_in('listing-description', with: 'It is pretty hidden')
    fill_in('listing-price', with: '75')
    fill_in('listing-fromdate', with: '2021-10-21')
    fill_in('listing-todate', with: '2021-10-30')
    click_button('List my Space')

    click_link('All Spaces')
    expect(page).to have_content('Space: 1')
    expect(page).to have_content('Boschtower')
    expect(page).to have_content('Medieval Nightmare Fuel')
    expect(page).to have_content('£75')
    expect(page).to have_content('Available From: Thu 21 October 2021')
    expect(page).to have_content('Available To: Sat 30 October 2021')

    expect(page).to have_content('Space: 2')
    expect(page).to have_content('Space: 3')
  end
end
