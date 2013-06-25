#!/usr/bin/env ruby

require 'symbolic'
require './fraction'

class Circle
  PI = var :name => 'π'

  def initialize(options={})
    if options[:radius]
      @radius = options[:radius]
    elsif options[:circumference]
      @radius = options[:circumference] / (2.0 * PI)
    elsif options[:diameter]
      @radius = options[:diameter] / 2.0
    elsif options[:area]
      @radius = Math.sqrt(options[:area] / PI)
    else
      raise 'No radius info given'
    end
  end

  def area
    PI * (@radius ** 2)
  end

  def /(circle)
    Fraction.new((area / PI), (circle.area / PI))
  end
end

if __FILE__ == $0
  @dartboard = Circle.new :diameter => 16
  @target    = Circle.new :circumference => (12 * Circle::PI)

  puts "target area:    #{@target.area}"
  puts "dartboard area: #{@dartboard.area}"

  puts @target / @dartboard
end
