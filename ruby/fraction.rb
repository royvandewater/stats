#!/usr/bin/env ruby

class Fraction
  attr_reader :numerator, :denominator

  def initialize(numerator, denominator)
    @numerator   = numerator
    @denominator = denominator
    reduce!
  end

  def reduce!
    gcd = numerator.to_i.gcd denominator.to_i
    @numerator   = numerator.to_i / gcd
    @denominator = denominator.to_i / gcd
  end

  def to_s
    "#{@numerator}/#{@denominator}"
  end

  def *(fraction)
    Fraction.new((@numerator * fraction.numerator), (@denominator * fraction.denominator))
  end
end
