class Request
  attr_reader :id, :start_date, :end_date, :booking_confirmed, :user_id, :space_id
  def initialize(id:, start_date:, end_date:, booking_confirmed:, user_id:, space_id:)
    @id = id
    @start_date = start_date
    @end_date = end_date
    @booking_confirmed = booking_confirmed
    @user_id = user_id
    @space_id = space_id
  end
  
  def self.find_my_requests(id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE user_id = $1", [id])
    result.map do |request|
      Request.new(id: request['id'], start_date: request['start_date'], end_date: request['end_date'], booking_confirmed: request['booking_confirmed'], user_id: request['user_id'], space_id: request['space_id'])
    end
  end
end