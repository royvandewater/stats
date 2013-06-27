#!/usr/bin/env ruby

require 'active_support/core_ext/enumerable' # provides [].sum
require './fraction'

class MarbleBag
  def initialize(marbles_by_color={})
    @marbles_by_color = marbles_by_color
  end

  def dependent_probability(*colors)
    probabilities = []

    colors.each do |color|
      probabilities  << Fraction.new(@marbles_by_color[color], marble_count)
      @marbles_by_color[color] -= 1
    end

    probabilities.reduce Fraction.new(1,1), :*
  end

  def marble_count
    @marbles_by_color.values.sum
  end
end

if __FILE__ == $0
  @marble_bag = MarbleBag.new :red => 4, :green => 5, :blue => 4
  puts @marble_bag.dependent_probability :red, :green
end
