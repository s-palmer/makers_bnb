# frozen_string_literal: true

class Booking
  attr_reader :id, :start_date, :end_date, :booking_confirmed, :user_id, :space_id

  def initialize(id:, start_date:, end_date:, booking_confirmed:, user_id:, space_id:)
    @id = id
    @start_date = start_date
    @end_date = end_date
    @booking_confirmed = booking_confirmed
    @user_id = user_id
    @space_id = space_id
  end

  def self.create(id:, start_date:, end_date:, booking_confirmed:, user_id:, space_id:)
    result = DatabaseConnection.query(
      "INSERT INTO bookings(
        start_date, end_date, booking_confirmed, user_id, space_id)
        VALUES ($1, $2, $3, $4, $5, $6)
        RETURNING id, start_date, end_date, booking_confirmed, user_id, space_id;",
      [start_date, end_date, booking_confirmed, user_id, space_id]
    )
    Request.new(
      id: result[0]['id'],
      start_date: result[0]['start_date'],
      end_date: result[0]['end_date'],
      booking_confirmed: result[0]['booking_confirmed'],
      user_id: result[0]['user_id'],
      space_id: result[0]['space_id']
    )
  end

  def self.find_my_requests(id:)
    result = DatabaseConnection.query('SELECT * FROM bookings WHERE user_id = $1', [id])
    
    result.map do |request|
      Request.new(id: request['id'], start_date: request['start_date'], end_date: request['end_date'],
                  booking_confirmed: request['booking_confirmed'], user_id: request['user_id'], space_id: request['space_id'])
    end
  end
end
