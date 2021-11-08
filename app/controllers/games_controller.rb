require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters].chars
    @guess_array = @guess.chars
    @url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    word_details = URI.open(@url).read
    word = JSON.parse(word_details)

    if (@guess_array - @letters).any?
      @message = "Sorry but #{@guess.upcase} can't be built out of #{@letters}!"
    elsif (@guess_array - @letters).empty? && word["found"] == false
      @message = "Sorry but #{@guess.upcase} doesn't seem to be a valid english word"
    elsif (@guess_array - @letters).empty? && word["found"] == true
      @message = "Well done! #{@guess.upcase} is in the grid and it is a valid english word!"
    end
  end
end
