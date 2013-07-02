#!/usr/bin/env ruby

require './fraction'

class Gaggle < Struct.new(:strange_goose_count, :total_goose_count)
  def all_strange_count
    strange_goose_count.downto(1).inject Fraction.new(1,1) do |accum, i|
      accum *= Fraction.new(strange_goose_count, total_goose_count)
      self.strange_goose_count -= 1
      self.total_goose_count   -= 1
      accum
    end
  end
end

if __FILE__ == $0
  @gaggle = Gaggle.new ARGV[0].to_i, ARGV[1].to_i
  puts @gaggle
  puts @gaggle.all_strange_count
end
