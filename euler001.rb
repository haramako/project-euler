# coding: utf-8
# Problem 1 「3と5の倍数」
def euler001
  (0...1000).select{|x| x % 3 == 0 or x % 5 == 0}.reduce(0){|m,x| m += x }
end
