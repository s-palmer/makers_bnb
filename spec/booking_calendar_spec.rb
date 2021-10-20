require 'booking_calendar'
require_relative '../lib/database_connection'

describe BookingCalendar do
  it 'should respond to .create' do
    expect(described_class).to receive(:create).with(space_id: 1, start_date:'2021-10-19', end_date:'2021-10-31')

    BookingCalendar.create(space_id: 1, start_date:'2021-10-19', end_date:'2021-10-31')
  end

  describe '.create' do
    it 'should store a range of dates in the dates table' do
      user = User.create(name: 'Test Name', email_address: 'test@example.com', password: 'password123')
      space = Space.create(
        name: 'TestSpace',
        description: 'A tranquil test space in test land.',
        price: 100,
        available_from: '2021-10-19 00:00:00',
        available_to: '2021-10-31 00:00:00',
        user_id: user.id
      )
      BookingCalendar.create(space_id: space.id, start_date:'2021-10-19', end_date:'2021-10-31')

      query = DatabaseConnection.query("SELECT * FROM dates;")

      expect(query[0]['date']).to include ('2021-10-19')
      expect(query[1]['date']).to include ('2021-10-20')
      expect(query[11]['date']).to include ('2021-10-30')
      expect(query[12]['date']).to include ('2021-10-31')
    end
  end
end