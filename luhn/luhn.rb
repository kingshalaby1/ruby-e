=begin
Write your code for the 'Luhn' exercise in this file. Make the tests in
`luhn_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/luhn` directory.
=end

class Luhn
  def self.valid?(n)
    return false if n.strip.length < 2 || n.chars.any? { |x| ![*'0'..'9', ' '].include?(x)}
    result = n.chars
         .select{ |x| [*'0'..'9'].include?(x)}
         .reverse
         .map.with_index{ | d, i |
            d = d.to_i
            if(i.odd?)
              d = ((d * 2) < 9 ? d * 2 : d * 2 - 9)
            end
            d
        }
    result.sum() % 10 == 0
  end
end

