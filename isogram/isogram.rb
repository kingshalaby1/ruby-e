=begin
Write your code for the 'Isogram' exercise in this file. Make the tests in
`isogram_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/isogram` directory.
=end
class Isogram
  def self.isogram?(input)
    res = input.downcase.chars.select do |x|
      [*'a'..'z'] .include?(x)
    end.group_by {_1}.map{_2.count}.max
    res.nil? ? true : res <= 1
  end
end

i = Isogram.isogram?("six-year-old")
puts i