require_relative "database_connection"
require 'date'

class BookingCalendar
  def initialize(space_id:, start_date:, end_date:)
    @space_id = space_id
    @start_date = start_date
    @end_date = end_date
  end

  def self.create(space_id:, start_date:, end_date:)
    DatabaseConnection.query(
      "INSERT INTO dates(date, available, space_id)
      SELECT i, 'TRUE', #{space_id}
      FROM generate_series(
      #{start_date}::date,
      #{finish_date}::date,
      '1 day') AS t(i);", []
    )
  end
end
