require 'space'
require 'database_helpers'
require 'user'

describe Space do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
      space = Space.create(
      name: 'TestSpace',
      description: 'A tranquil test space in test land.',
      price: 100,
      available_from: '2021-10-19 00:00:00',
      available_to: '2021-10-31 00:00:00')
      # user_id: user.id)
      persisted_data = persisted_data(table: :spaces, id: space.id)

      expect(space).to be_a Space
      expect(space.id).to eq persisted_data.first['id']
      expect(space.name).to eq 'TestSpace'
      expect(space.description).to eq 'A tranquil test space in test land.'
      # expect(space.user_id).to eq user.id
    end
  end
end