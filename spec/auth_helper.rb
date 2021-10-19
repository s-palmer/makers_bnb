# frozen_string_literal: true

require 'pg'

def log_in_to_site
  User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')

  visit '/'
  click_button 'Sign In'
  fill_in(:email_address_si, with: 'test@example.com')
  fill_in(:password_si, with: 'password123')
  click_button('Enter')
end
