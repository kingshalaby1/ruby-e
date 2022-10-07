=begin
Write your code for the 'Clock' exercise in this file. Make the tests in
`clock_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/clock` directory.
=end


class Clock
  attr_accessor :hour, :minute
  def initialize(**hash)
    hash.default = 0
    diff = hash[:minute] / 60
    @hour= (hash[:hour] + diff) % 24
    @minute= hash[:minute] % 60
  end

  def + (cl)
    self.class.new(**{hour: self.hour+cl.hour, minute: self.minute+cl.minute})

  end
  def - (cl)
    m = minute - cl.minute
    h = hour - cl.hour
    while m < 0 do
      m += 60
      h -= 1
    end
    while h < 0 do
      h += 24
    end
    self.class.new(**{hour: h, minute: m})

  end

  def == (cl)
    self.hour == cl.hour && self.minute == cl.minute
  end

  def self.parse_str(str)
    hour = str[0,2].to_i
    minute = str[3,2].to_i
    new(**{hour: hour, minute: minute})

  end
  def to_s()
    "#{'0' if hour.to_s.size==1}#{hour}:#{'0' if minute.to_s.size==1}#{minute}"
  end
end
#
# clock = Clock.new(hour: 10, minute: 3)
# p (clock - Clock.new(minute: 30)).to_s


