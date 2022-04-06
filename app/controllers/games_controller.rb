require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }

  end

  def score
    @letters
    @english_word
    @included?
    @attempt
  end

  private

  def included?(attempt, grid)
    attempt.chars.all? do |letter|
      attempt.count(letter) <= grid.count(letter)
    end
  end

  def english_word(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    json_string = URI.open(url).read
    result = JSON.parse(json_string)
    return result['found']
  end
end
