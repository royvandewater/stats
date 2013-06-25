#!/usr/bin/env ruby

require 'active_support/core_ext/array'      # provides [].second
require 'active_support/core_ext/enumerable' # provides [].sum

class TwoDice
  def initialize
    @black = [1,2,3,4,5,6]
    @white = [1,2,3,4,5,6]
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
end

if __FILE__ == $0
  @two_dice = TwoDice.new
  puts @two_dice.probability_roll_contains_a(3).to_s
end
