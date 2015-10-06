class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :check_win_or_lose
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = ''
    word.each_char do |i|
      @word_with_guesses << '-'
    end
    @check_win_or_lose = :play
  end
  
  
  def guess(letter)
    #raise ArgumentError if letter is nil or not a letter
    raise ArgumentError if letter.nil?
    raise ArgumentError if letter == ''
    raise ArgumentError if !letter.match(/[a-zA-Z]/)
    
    letter.downcase!
    #if the letter is in the secret word and isn't a repeat guess, record the guess as right
    if word.include? letter
      unless guesses.include? letter
        guesses << letter
        for i in 0..word.length
          if word[i] == letter
            word_with_guesses[i] = letter
            @check_win_or_lose = :win if !word_with_guesses.include? '-'
          end
        end
        return true
      end
    #else if the letter is not in the secret word and isn't a repeat guess, record the guess as wrong
    else
      unless wrong_guesses.include? letter
        wrong_guesses << letter
        if wrong_guesses.size >= 7
          @check_win_or_lose = :lose
        end
        return true
      end
    end
    #else it is a repeat guess and we must return false
    return false
  end

    


  
  # Random word grabber from the dictionary
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
