def euler016
  (2 ** 1000).to_s.each_char.map{|s| s.to_i}.reduce(0){|m,n| m += n}
end
