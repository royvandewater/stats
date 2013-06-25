#!/usr/bin/env ruby

require './fraction'

class Circle
  PI = -1

  def initialize(options={})
    if options[:radius]
      @radius = options[:radius].to_f
    elsif options[:circumference]
      @radius = options[:circumference].to_f / (2.0 * PI)
    elsif options[:diameter]
      @radius = options[:diameter].to_f / 2.0
    elsif options[:area]
      @radius = Math.sqrt(options[:area].to_f / PI)
    else
      raise 'No radius info given'
    end
  end

  def area
    (PI * (@radius ** 2)).abs
  end
end

if __FILE__ == $0
  @dartboard = Circle.new :diameter => 16
  @target    = Circle.new :circumference => (12 * Circle::PI)

  puts "target area:    #{@target.area}"
  puts "dartboard area: #{@dartboard.area}"

  puts Fraction.new(@target.area, @dartboard.area)
end
