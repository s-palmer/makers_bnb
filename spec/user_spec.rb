# frozen_string_literal: true

require 'user'
require 'database_helpers'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
      persisted_data = persisted_data(table: :users, id: user.id)

      expect(user).to be_a User
      expect(user.id).to eq persisted_data.first['id']
      expect(user.name).to eq 'Test Name'
      expect(user.email_address).to eq 'test@example.com'
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password123')

      User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
    end
  end

  describe '.authenticate' do
    it 'returns a user given a correct username and password, if one exists' do
      user = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
      authenticated_user = User.authenticate(email_address: 'test@example.com', password: 'password123')

      expect(authenticated_user.id).to eq user.id
    end

    it 'returns nil given an incorrect email address' do
      user = User.create(email_address: 'test@example.com', name: 'test guy', password: 'password123')

      expect(User.authenticate(email_address: 'nottherightemail@example.com', password: 'password123')).to be_nil
    end

    it 'returns nil given an incorrect password' do
      user = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')

      expect(User.authenticate(email_address: 'test@example.com', password: 'wrongpassword')).to be_nil
    end
  end

  describe '.find' do
    it 'finds a user by ID' do
      user = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
      result = User.find(id: user.id)

      expect(result.id).to eq user.id
      expect(result.email_address).to eq user.email_address
      expect(result.name).to eq user.name
    end

    it 'returns nil if there is no ID given' do
      expect(User.find(id: nil)).to eq nil
    end
  end
end
