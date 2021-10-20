# frozen_string_literal: true

feature 'Viewing Host Spaces' do
  scenario 'User should be able to view the spaces they have listed' do
    user = User.create(name: 'Test Name', email_address: 'test1@example.com', password: 'password123')
    host = User.create(name: 'Test Name Other', email_address: 'test2@example.com', password: 'password123')
    space = Space.create(
      name: 'TestSpace',
      description: 'A tranquil test space in test land.',
      price: 100,
      available_from: '2021-10-19 00:00:00',
      available_to: '2021-10-31 00:00:00',
      user_id: host.id
    )
    DatabaseConnection.query("INSERT INTO bookings (start_date, end_date, booking_confirmed, user_id, space_id, host_id)
      VALUES ('2021-11-18 15:44:02.776337', '2021-12-18 15:44:02.776337', false, #{user.id}, #{space.id}, #{host.id} );")

    visit '/'
    click_button 'Sign In'
    fill_in(:email_address_si, with: 'test2@example.com')
    fill_in(:password_si, with: 'password123')
    click_button('Enter')
    click_link 'my-spaces'

    expect(page).to have_content('TestSpace')
  end
end
