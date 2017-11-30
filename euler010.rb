def euler010
  Prime.each.take_while{|n| n <= 2000000 }.reduce(0){|m,n| m += n }
end
