=begin
Write your code for the 'Matrix' exercise in this file. Make the tests in
`matrix_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/matrix` directory.
=end

class Matrix

  attr_accessor :rows, :columns
  def initialize(str)
    @columns = []
    @rows = str.each_line.map{_1.split.map(&:to_i)}
    @rows.each_with_index { |x, y, | @columns[y] = @rows.map{|r| r[y]} }
  end
end