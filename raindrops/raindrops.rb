=begin
Write your code for the 'Raindrops' exercise in this file. Make the tests in
`raindrops_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/raindrops` directory.
=end
class Raindrops
  def self.convert(i)
    res = ""
    i = i.to_i
    if i % 3 == 0
      res += "Pling"
    end
    if i % 5 == 0
      res += "Plang"
    end
    if i % 7 == 0
      res += "Plong"
    end
    return (res.empty? ? i.to_s : res)

  end
end