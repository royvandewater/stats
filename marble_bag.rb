#!/usr/bin/env ruby

require 'active_support/core_ext/enumerable' # provides [].sum
require './fraction'

class MarbleBag
  def initialize(marbles_by_color={})
    @marbles_by_color = marbles_by_color
  end

  def dependent_probability(*colors)
    colors.inject Fraction.new(1,1) do |accumulator, color|
      accumulator *= Fraction.new(@marbles_by_color[color], marble_count)
      @marbles_by_color[color] -= 1
      accumulator
    end
  end

  def marble_count
    @marbles_by_color.values.sum
  end
end

if __FILE__ == $0
  @marble_bag = MarbleBag.new :red => ARGV[0].to_i, :green => ARGV[1].to_i, :blue => ARGV[2].to_i
  puts "list: #{ARGV[3..-1].map(&:to_sym)}"
  puts @marble_bag.dependent_probability *ARGV[3..-1].map(&:to_sym)
end
