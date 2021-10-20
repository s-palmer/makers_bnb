# frozen_string_literal: true

require 'date'
require 'auth_helper'

feature 'Viewing Requests' do
  scenario 'viewing the requests user has made' do
    user = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
    host = User.create(name: 'Test Name Other', email_address: 'test2@example.com', password: 'password123')

     space = Space.create(
        name: 'TestSpace',
        description: 'A tranquil test space in test land.',
        price: 100,
        available_from: '2021-10-19 00:00:00',
        available_to: '2021-10-31 00:00:00',
        user_id: user.id
      )
      DatabaseConnection.query("INSERT INTO bookings (start_date, end_date, booking_confirmed, user_id, space_id, host_id) VALUES ('2021-11-18 15:44:02.776337', '2021-12-18 15:44:02.776337', false, #{user.id}, #{space.id}, #{host.id} );")

    visit '/'
    click_button 'Sign In'
    fill_in(:email_address_si, with: 'test@example.com')
    fill_in(:password_si, with: 'password123')
    click_button('Enter')

    click_link 'Requests'
    expect(page).to have_content("Requests I've made:")
    expect(page).to have_content('Space: 1')
    expect(page).to have_content('Thu 18 Nov 2021')
  end

  
  scenario 'viewing the requests user has received' do
    host = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
    user = User.create(name: 'Bob', email_address: 'test2@example.com', password: 'password123')
    space = Space.create(
          name: 'TestSpace',
          description: 'A tranquil test space in test land.',
          price: 100,
          available_from: '2021-10-19 00:00:00',
          available_to: '2021-10-31 00:00:00',
          user_id: user.id
        )

    DatabaseConnection.query("INSERT INTO bookings (start_date, end_date, booking_confirmed, user_id, space_id, host_id) VALUES 
      ('2021-11-18 15:44:02.776337', '2021-12-18 15:44:02.776337', false, #{user.id}, #{space.id}, #{host.id} );")

    visit '/'
    click_button 'Sign In'
    fill_in(:email_address_si, with: 'test@example.com')
    fill_in(:password_si, with: 'password123')
    click_button('Enter')

    click_link 'Requests'
    expect(page).to have_content("Requests I've received:")
    expect(page).to have_content("Space: 1")
    expect(page).to have_content("Renter: Bob")
    expect(page).to have_content("Thu 18 Nov 2021")
  end

  scenario 'viewing alert if logged out user tries to view requests' do
    host = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
    user = User.create(name: 'Bob', email_address: 'test2@example.com', password: 'password123')
    space = Space.create(
          name: 'TestSpace',
          description: 'A tranquil test space in test land.',
          price: 100,
          available_from: '2021-10-19 00:00:00',
          available_to: '2021-10-31 00:00:00',
          user_id: user.id
        )

    DatabaseConnection.query("INSERT INTO bookings (start_date, end_date, booking_confirmed, user_id, space_id, host_id) VALUES 
      ('2021-11-18 15:44:02.776337', '2021-12-18 15:44:02.776337', false, #{user.id}, #{space.id}, #{host.id} );")

    visit '/requests'
    expect(page).not_to have_content("Requests I've received:")
    expect(page).to have_content("Please login to view this page.")
  end

  scenario 'view confirm and deny buttons for incoming requests' do
    host = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
    user = User.create(name: 'Bob', email_address: 'test2@example.com', password: 'password123')
    space = Space.create(
          name: 'TestSpace',
          description: 'A tranquil test space in test land.',
          price: 100,
          available_from: '2021-10-19 00:00:00',
          available_to: '2021-10-31 00:00:00',
          user_id: user.id
        )

    DatabaseConnection.query("INSERT INTO bookings (start_date, end_date, booking_confirmed, user_id, space_id, host_id) VALUES 
      ('2021-11-18 15:44:02.776337', '2021-12-18 15:44:02.776337', false, #{user.id}, #{space.id}, #{host.id} );")

    visit '/'
    click_button 'Sign In'
    fill_in(:email_address_si, with: 'test@example.com')
    fill_in(:password_si, with: 'password123')
    click_button('Enter')

    visit '/requests'
    expect(page).to have_content("Confirm Booking Request?")
    expect(page).to have_content("Deny Booking Request?")
  end
end

