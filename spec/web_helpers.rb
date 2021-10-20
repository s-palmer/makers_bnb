def create_user_and_sign_in
  User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
  visit '/'
  click_button 'Sign In'
  fill_in(:email_address_si, with: 'test@example.com')
  fill_in(:password_si, with: 'password123')
  click_button('Enter')
end

def new_space_creation
  fill_in('listing-name', with: 'Hertfordshire Hideaway')
  fill_in('listing-description', with: 'It is pretty hidden')
  fill_in('listing-price', with: '75')
  fill_in('listing-fromdate', with: '2021-10-21')
  fill_in('listing-todate', with: '2021-10-30')
  click_button('List my Space')
end

