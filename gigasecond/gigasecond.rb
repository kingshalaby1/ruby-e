=begin
Write your code for the 'Gigasecond' exercise in this file. Make the tests in
`gigasecond_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/gigasecond` directory.
=end


class Gigasecond
  def self.from(time)
    p time + 1000000000
  end
end

Gigasecond.from(Time.utc(2011, 4, 25, 0, 0, 0))
