def euler009
  max = 1000
  a_min = 1000 / 3 + 1
  (a_min..max).each do |a|
    b_min = (max - a) / 2 + 1
    (b_min..a).each do |b|
      c = max - a - b
      if (b ** 2 + c ** 2) == (a ** 2)
        return a*b*c if a + b + c == 1000
      end
    end
  end
  raise
end
