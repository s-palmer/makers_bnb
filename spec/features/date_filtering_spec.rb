feature 'Date Filter' do
  scenario 'a user filter available spaces by date' do
    user = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
    space = Space.create(
      name: 'TestSpace1',
      description: 'A tranquil test space in test land.',
      price: 100,
      available_from: '2021-10-01 00:00:00',
      available_to: '2021-10-02 00:00:00',
      user_id: user.id
    )
    space = Space.create(
      name: 'TestSpace2',
      description: 'A tranquil test space in test land.',
      price: 100,
      available_from: '2021-11-01 00:00:00',
      available_to: '2021-11-03 00:00:00',
      user_id: user.id
    )
    space = Space.create(
      name: 'TestSpace3',
      description: 'A tranquil test space in test land.',
      price: 100,
      available_from: '2021-10-19 00:00:00',
      available_to: '2021-10-25 00:00:00',
      user_id: user.id
    )
    visit '/spaces'
    fill_in(:booking_date, with: '2021-11-02')
    click_button('Filter')
    expect(page).to have_content 'TestSpace2'
    expect(page).to_not have_content 'TestSpace1'
    expect(page).to_not have_content 'TestSpace3'
  end
end