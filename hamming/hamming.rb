=begin
Write your code for the 'Hamming' exercise in this file. Make the tests in
`hamming_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/hamming` directory.
=end
class Hamming

  def self.compute(first, second)
    raise ArgumentError unless first.length == second.length


    (0...first.length).count {|x| first[x] != second[x]}
  end
end