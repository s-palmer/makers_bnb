require "date"

class Calendar
  def self.new
    head = Date.today.strftime("%B %Y")
    year = Date.today.year
    mon = Date.today.mon
    firstday_wday = Date.new(year, mon, 1).wday
    lastday_date = Date.new(year, mon, -1).day
    week = %w(Su Mo Tu We Th Fr Sa)

    puts head.center(20)
    puts week.join(" ")
    print "   " * firstday_wday

    wday = firstday_wday
    (1..lastday_date).each do |date|
      print date.to_s.rjust(2) + " "
      wday = wday + 1
      if wday % 7 == 0
        print "\n"
      end
    end
    if wday % 7 != 0
      print "\n"
    end
  end
end
