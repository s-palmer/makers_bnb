# frozen_string_literal: true

require 'pg'

p 'Setting up test database...'

def setup_test_database
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec('TRUNCATE users, spaces, dates, bookings RESTART IDENTITY;')
end
