class WordGuesserGame
  # @return [String]
  attr_reader :word, :guesses, :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @try = 0
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, '').body
    end
  end

  # @param [String] s <description>
  #
  # @return [Bool] <description>
  #
  def guess(c)
    raise ArgumentError if c.nil?

    raise ArgumentError unless c.downcase <= 'z' && c.downcase >= 'a'
    raise ArgumentError if c == ''
    return false if (@guesses.include? c.downcase) || (@wrong_guesses.include? c.downcase)

    @try += 1
    if @word.include? c
      @guesses += c
    else
      @wrong_guesses += c
    end
    true
  end

  def word_with_guesses
    res = ''
    @word.each_char do |c|
      res += if @guesses.include? c
               c
             else
               '-'
             end
    end
    res
  end

  def check_win_or_lose
    return :win if word_with_guesses == @word
    return :lose if @try > 7
    return :play if @try < 7

    :lose
  end
end
