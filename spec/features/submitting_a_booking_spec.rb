# frozen_string_literal: true

feature 'Submitting a Booking Request' do
  scenario 'User should be able to make a booking' do
    user = User.create(name: 'Test Name', email_address: 'test1@example.com', password: 'password123')
    host = User.create(name: 'Test Name Other', email_address: 'test2@example.com', password: 'password123')
    space = Space.create(
      name: 'TestSpace',
      description: 'A tranquil test space in test land.',
      price: 100,
      available_from: '2021-10-19 00:00:00',
      available_to: '2021-10-31 00:00:00',
      user_id: host.id,
      url: 'https://dhcottages.co.uk/wp-content/uploads/2018/02/White-Sands-Pet-Friendly-Sea-View-Swanage-view-to-sea-1.jpg'
    )
    DatabaseConnection.query("INSERT INTO bookings (start_date, end_date, booking_confirmed, user_id, space_id, host_id)
      VALUES ('2021-11-18 15:44:02.776337', '2021-12-18 15:44:02.776337', false, #{user.id}, #{space.id}, #{host.id} );")

    visit '/'
    click_button 'Sign In'
    fill_in(:email_address_si, with: 'test2@example.com')
    fill_in(:password_si, with: 'password123')
    click_button('Enter')
    click_link 'All Spaces'
    click_button("View")
    click_button('book_request_button')
    fill_in(:listing_fromdate, with: '2021-10-21')
    fill_in(:listing_todate, with: '2021-10-28')
    click_button('Submit')
    expect(page).to have_text("Requests", normalize_ws: true)
  end
end
