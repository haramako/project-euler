def euler009
  max = Math.sqrt(1000).to_i
  (1..max).each do |a|
    (a..max).each do |b|
      (b..max).each do |c|
        return a*b*c if a ** 2 + b ** 2 + c ** 2 == 1000
      end
    end
  end
  raise
end
