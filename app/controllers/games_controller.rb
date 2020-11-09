require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters].split(" ")
    p @answer
    p @letters
    # pour chaque lettre de answer, vérifier si présente dans letters et si oui, retirer de letter
    if included?(@answer.upcase, @letters)
      if is_english?(@answer)
        return @result = 0
      end
        return @result = 1
    else
      return @result = 3
    end
  end

  private

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter)}
  end

  def is_english?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
