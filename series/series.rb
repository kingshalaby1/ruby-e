=begin
Write your code for the 'Series' exercise in this file. Make the tests in
`series_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/series` directory.
=end
class Series

  def initialize(string)
    @string = string.chars
  end
  def slices(l)
    raise ArgumentError if l > @string.length
    @string.map.with_index {|x, i| @string[i, l].join}.reject {|x| x.length < l}
  end
end