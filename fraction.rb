#!/usr/bin/env ruby

class Fraction
  def initialize(numerator, denominator)
    gcd = numerator.to_i.gcd denominator.to_i
    @numerator   = numerator.to_i / gcd
    @denominator = denominator.to_i / gcd
  end

  def to_s
    "#{@numerator}/#{@denominator}"
  end
end
