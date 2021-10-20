# frozen_string_literal: true

require 'booking'

describe Booking do
  DatabaseConnection.query("TRUNCATE users CASCADE")
  describe ".all_incoming" do
    it "should return all bookings for users's spaces" do
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
      DatabaseConnection.query("INSERT INTO bookings (start_date, end_date, booking_confirmed, user_id, space_id, host_id)
       VALUES ('2021-11-18 15:44:02.776337', '2021-12-18 15:44:02.776337', false, #{user.id}, #{space.id}, #{host.id} );")
      
      expect(Booking.all_incoming(id: host.id)[0].user_id).to eq("1")
    end
  end

  # describe ".confirm" do
  #   it "should change confirmed from false to true" do
  #     Booking.confirm(id: )
  #     expect(subject.booking_confirmed).to eq(true)
  #   end 
  # end

end
