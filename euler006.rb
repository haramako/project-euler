def euler006
  sum = (1..100).map{|x| x ** 2}.reduce(0){|m,n| m+=n}
  prod = (1..100).reduce(0){|m,n| m+=n} ** 2
  prod - sum
end
