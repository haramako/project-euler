# coding: utf-8
require 'prime' # MEMO: primeをつかうのはちょっとズルい

def euler005
  all_divs = {}
  (1..20).each do |n|
    divs = Prime.prime_division(n)
    divs.each do |prime, num|
      all_divs[prime] ||= 0
      all_divs[prime] = [all_divs[prime], num].max
    end
  end
  r = 1
  all_divs.each{|k,v| r *= k ** v}
  r
end

