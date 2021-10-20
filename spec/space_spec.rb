# frozen_string_literal: true

require 'space'
require 'database_helpers'
require 'user'
require_relative 'database_helpers'

describe Space do
  describe '.create' do
    it 'creates a new space' do
      user = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
      space = Space.create(
        name: 'TestSpace',
        description: 'A tranquil test space in test land.',
        price: 100,
        available_from: '2021-10-19 00:00:00',
        available_to: '2021-10-31 00:00:00',
        user_id: user.id
      )
      persisted_data = persisted_data(table: :spaces, id: space.id)

      expect(space).to be_a Space
      expect(space.id).to eq persisted_data.first['id']
      expect(space.name).to eq 'TestSpace'
      expect(space.description).to eq 'A tranquil test space in test land.'
      expect(space.user_id).to eq user.id
    end
  end

  describe '.all' do
    it 'returns a list of all spaces' do
      connection = PG.connect(dbname: 'makers_bnb_test')
      connection.exec("INSERT INTO users (id, name, email_address, password) VALUES (1, 'Test', 'test@example.com', 'password');")
      space = Space.create(
        name: 'TestSpace',
        description: 'A tranquil test space in test land.',
        price: 100,
        available_from: '2021-10-19 00:00:00',
        available_to: '2021-10-31 00:00:00',
        user_id: 1
      )
      Space.create(
        name: 'TestSpace2',
        description: 'A tranquil test space in test land.',
        price: 100,
        available_from: '2021-10-19 00:00:00',
        available_to: '2021-10-31 00:00:00',
        user_id: 1
      )
      Space.create(
        name: 'TestSpace3',
        description: 'A tranquil test space in test land.',
        price: 100,
        available_from: '2021-10-19 00:00:00',
        available_to: '2021-10-31 00:00:00',
        user_id: 1
      )
      spaces = Space.all

      expect(spaces.length).to eq 3
      expect(spaces.first.id).to eq space.id
      expect(spaces.first.name).to eq 'TestSpace'
      expect(spaces.first.description).to eq 'A tranquil test space in test land.'
      expect(spaces.first.price).to eq '100'
    end
  end


 describe '.find' do
    it 'finds a user by ID' do
      user = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
      space = Space.create(
        name: 'TestSpace',
        description: 'A tranquil test space in test land.',
        price: 100,
        available_from: '2021-10-19 00:00:00',
        available_to: '2021-10-31 00:00:00',
        user_id: user.id
      )
      
      result = Space.find(id: space.id).first

      expect(result.id).to eq space.id
    end
  end

  describe '.mine' do
    it 'returns a list of the spaces I have listed' do
      connection = PG.connect(dbname: 'makers_bnb_test')
      connection.exec("INSERT INTO users (id, name, email_address, password) VALUES (1, 'Test', 'test@example.com', 'password');")
      DatabaseConnection.query("TRUNCATE users CASCADE")
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
      
      result = Space.find(id: space.id).first
      expect(result.id).to eq space.id

      Space.create(
        name: 'TestSpace2',
        description: 'A tranquil test space in test land.',
        price: 100,
        available_from: '2021-10-19 00:00:00',
        available_to: '2021-10-31 00:00:00',
        user_id: host.id
      )
      Space.create(
        name: 'TestSpace3',
        description: 'A tranquil test space in test land.',
        price: 100,
        available_from: '2021-10-19 00:00:00',
        available_to: '2021-10-31 00:00:00',
        user_id: user.id
      )
      spaces = Space.mine(id: host.id)

      expect(spaces.length).to eq 2
      expect(spaces.first.id).to eq space.id
      expect(spaces.first.name).to eq 'TestSpace'
      expect(spaces.first.description).to eq 'A tranquil test space in test land.'
      expect(spaces.first.price).to eq '100'

    end
  end
end
