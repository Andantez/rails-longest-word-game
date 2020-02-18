# frozen_string_literal: true

require 'open-uri'
require 'json'

# dadsad
class GamesController < ApplicationController
  def new
    letters = ('A'..'Z').to_a.sample(10)
    @letters = letters

    @letters
  end

  def score
    @answer = params[:word].downcase
    url = URI("https://wagon-dictionary.herokuapp.com/#{@answer}")
    word_dictionary = open(url).read
    @words = JSON.parse(word_dictionary)
    if @words['found']
      @valid_or_not = 'Congratulations this is a valid english word'
    elsif !all_letters_included
      @valid_or_not = "Sorry but #{params[:word]} cant be buil out of #{@letters} "

    elsif @words['found'] == false
      @valid_or_not = 'This is not a valid english word'
    end
  end

  def all_letters_included
    # @answer.chars.sort.all? { |letter| @letters.include?(letter) }
  end
end
