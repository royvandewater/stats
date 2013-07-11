#!/usr/bin/env ruby

require 'active_support/core_ext/array'      # provides [].second
require 'active_support/core_ext/enumerable' # provides [].sum

class TwoDice
  def initialize(options={})
    @black = (1..options[:black]).to_a
    @white = (1..options[:white]).to_a
  end

  def permutations
    @black.map do |b|
      @white.map do |w|
        [b,w]
      end
    end.flatten 1
  end

  def permutations_die_are_same
    permutations.select do |permutation|
      permutation.uniq.count == 1
    end
  end

  def permutations_both_are(n)
    permutations.select do |permutation|
      permutation.all? {|x| x == n}
    end
  end

  def permutations_less_than_or_equal_to(n)
    permutations.select do |permutation|
      permutation.sum <= n
    end
  end

  def permutations_roll_contains_a(n)
    permutations.select do |permutation|
      permutation.include? n
    end
  end

  def permutations_sum_of(n)
    permutations.select do |permutation|
      permutation.sum == n
    end
  end

  def probability_die_are_same
    [permutations_die_are_same.count, permutations.count]
  end

  def probability_roll_is_less_than_or_equal_to(n)
    [permutations_less_than_or_equal_to(n).count, permutations.count]
  end

  def probability_roll_contains_a(n)
    [permutations_roll_contains_a(n).count, permutations.count]
  end

  def probability_both_are(n)
    [permutations_both_are(n).count, permutations.count]
  end

  def probability_sum_of(n)
    [permutations_sum_of(n).count, permutations.count]
  end

  def to_s
    "{:black => #{@black.count}, :white => #{@white.count}}"
  end
end

# Bring OptionParser into the namespace

if __FILE__ == $0
  require 'optparse'
  options = {:black => 6, :white => 6}

  option_parser = OptionParser.new do |opts|
    opts.on('-b[sides]','--black=[sides]')     { |n| options[:black]    = n.to_i }
    opts.on('-w[sides]','--white=[sides]')     { |n| options[:white]    = n.to_i }
    opts.on('-o[value]','--both=[value]')      { |n| options[:both]     = n.to_i }
    opts.on('-c[value]','--contains=[value]')  { |n| options[:contains] = n.to_i }
    opts.on('-a',       '--same')              {     options[:same]     = true   }
    opts.on('-s[value]','--sum=[value]')       { |n| options[:sum]      = n.to_i }
    opts.on('--less-than-or-equal-to=[value]') { |n| options[:lte]      = n.to_i }
  end
  option_parser.parse!

  @two_dice = TwoDice.new :black => options[:black], :white => options[:white]

  if options[:both] || options[:contains] || options[:sum]
    puts "Two Dice: #{@two_dice}"
    puts "both #{options[:both]}: #{@two_dice.probability_both_are options[:both]}" if options[:both]
    puts "contains #{options[:contains]}: #{@two_dice.probability_roll_contains_a options[:contains]}" if options[:contains]
    puts "sum #{options[:sum]}: #{@two_dice.probability_sum_of options[:sum]}" if options[:sum]
    puts "less than or equal to #{options[:lte]}: #{@two_dice.probability_roll_is_less_than_or_equal_to options[:lte]}" if options[:lte]
    puts "same: #{@two_dice.probability_die_are_same}" if options[:same]
  else
    puts option_parser.help
  end
end
