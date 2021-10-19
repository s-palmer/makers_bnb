require "date"

feature "Viewing Requests" do
  scenario "viewing the requests user has made" do
    user = User.create(email_address: 'test@example.com', name: 'test guy', password: 'password123')
    space = Space.create(name: 'TestSpace', description: 'A tranquil test space in test land.', price: 100, user_id: user.id)
    DatabaseConnection.query("INSERT INTO bookings (start_date, end_date, booking_confirmed, user_id, space_id) VALUES ('2021-11-18 15:44:02.776337', '2021-12-18 15:44:02.776337', false, #{user.id}, #{space.id} );")

    visit '/sessions/new'
    fill_in(:email, with: 'test456')
    fill_in(:password, with: 'password123')
    click_button('Sign in')
    visit ('/requests')
    expect(page).to have_content("Requests I've made:")
    expect(page).to have_content('Booking Request for #{space_id}')

  end
  scenario "viewing the requests user has received" do
    User.create(email_address: 'test@example.com', name: 'test guy', password: 'password123')
    # DatabaseConnection.query("INSERT INTO bookings") Add in space and booking

    visit '/sessions/new'
    fill_in(:email, with: 'test456')
    fill_in(:password, with: 'password123')
    click_button('Sign in')
    visit ('/requests')
    expect(page).to have_content("Requests I've received:")
  end
end