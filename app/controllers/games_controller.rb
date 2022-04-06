require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }

  end

  def score
    @letters = params[:letters]
    @english_word = english_word(@word)
    @included = included?(@word, @letters)
    @word
  end

  private

  def included?(word, letters)
    @word.chars.all? do |letter|
      @word.count(letter) <= @letters.count(letter)
    end
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    json_string = URI.open(url).read
    result = JSON.parse(json_string)
    return result['found']
  end
end
