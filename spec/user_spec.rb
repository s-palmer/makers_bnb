require 'user'
require 'database_connection'

describe User do
  describe '.authenticate' do
    it 'returns a user given a correct username and password, if one exists' do
      user = User.create(email_address: 'test@example.com', name: 'test guy', password: 'password123')

      authenticated_user = User.authenticate(email_address: 'test@example.com', password: 'password123')
  
      expect(authenticated_user.email_address).to eq user.email_address
    end
    it 'returns nil given an incorrect email address' do
    user = User.create(email_address: 'test@example.com', name: 'test guy', password: 'password123')

      expect(User.authenticate(email_address: 'nottherightemail@example.com', password: 'password123')).to be_nil
    end
    it 'returns nil given an incorrect password' do
      user = User.create(email_address: 'test@example.com', name: 'test guy', password: 'password123')

      expect(User.authenticate(email_address: 'test@example.com', password: 'wrongpassword')).to be_nil
    end
  end
end