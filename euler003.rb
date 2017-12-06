# coding: utf-8
require 'prime' # MEMO: primeをつかうのは、ちょっとインチキ

def euler003
  Prime.prime_division(600851475143).map{|x| x[0]}.max
end
