class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses= ''
  end

   def guess(letter)
    if letter.nil? || letter.length != 1 || letter !~ /[a-zA-Z]/
      raise ArgumentError
    end

    letter = letter.downcase

    if @word.include?(letter) and !guesses.include?(letter)
      @guesses += letter
    elsif !@word.include?(letter) and !wrong_guesses.include?(letter)
      @wrong_guesses += letter
    else
      return false
    end

    true
  end  

  def word_with_guesses
    result = ""

    @word.each_char do |letter|
      if @guesses.include?(letter)
        result += letter
      else
        result += "-"
      end
    end

    result
  end

  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

  # Setter method
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord.txt')
    Net::HTTP.get(uri)
  end
end
