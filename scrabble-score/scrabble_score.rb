=begin
Write your code for the 'Scrabble Score' exercise in this file. Make the tests in
`scrabble_score_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/scrabble-score` directory.
=end
class Scrabble
  def initialize(word)
    @word = word
  end

  def self.score(str)
    new(str).score
  end
  def score
    return 0 if @word.nil?
    @word.strip.upcase.chars.inject(0){_1 + calc(_2)}
  end

  def calc(c)
    case c
      when *['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T']
        1
      when *['D', 'G']
        2
      when *['B', 'C', 'M', 'P']
        3
      when *['F', 'H', 'V', 'W', 'Y']
        4
      when 'K'
        5
      when *['J', 'X']
      8
      when *['Q', 'Z']
      10
     else
      0
    end
  end
end