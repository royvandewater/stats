#!/usr/bin/env ruby

class HandShakes
  def initialize(options={})
    @people = (1..options[:people].to_i).to_a
  end

  def combinations
    @people.combination(2)
  end
end

if __FILE__ == $0
  if ARGV.count == 1
    @hand_shakes = HandShakes.new :people => ARGV.first
    puts @hand_shakes.combinations.count
  else
    puts "Usage: \n\t./hand_shakes.rb [number_of_people]"
  end
end
