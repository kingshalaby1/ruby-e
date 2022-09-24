=begin
Write your code for the 'Word Count' exercise in this file. Make the tests in
`word_count_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/word-count` directory.
=end
class Phrase

  def initialize(str)
    @str = str
  end

  def word_count

    res = Hash.new(0)
    @str.chars.map do |x|
      x = x.downcase
      [*'a'..'z'].include?(x) || [*'0'..'9', '\''].include?(x) ? x : ' '

    end
        .join
        .split
        .map {_1.gsub(/^\'|\'$/, '')}
        .map{|w| res[w] += 1}
    res
  end
end

