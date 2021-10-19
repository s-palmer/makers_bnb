# frozen_string_literal: true

require 'pg'

def persisted_data(id:, table:)
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.query("SELECT * FROM #{table} WHERE ID = '#{id}';")
end

def create_test_spaces
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec("INSERT INTO users (id, name, email_address, password) VALUES (1, 'Test', 'test@example.com', 'password');")
  space = Space.create(
    name: 'TestSpace',
    description: 'A tranquil test space in test land.',
    price: 100,
    available_from: '2021-10-19 00:00:00',
    available_to: '2021-10-31 00:00:00'
  )
  Space.create(
    name: 'TestSpace2',
    description: 'A tranquil test space in test land.',
    price: 100,
    available_from: '2021-10-19 00:00:00',
    available_to: '2021-10-31 00:00:00'
  )
  Space.create(
    name: 'TestSpace3',
    description: 'A tranquil test space in test land.',
    price: 100,
    available_from: '2021-10-19 00:00:00',
    available_to: '2021-10-31 00:00:00'
  )
end
