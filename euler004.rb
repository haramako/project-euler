def euler004
  r = 0
  (100..999).each do |a|
    (a..999).each do |b|
      n_ = n = a * b
      next if n <= r
      nums = []
      while n > 0
        nums << n % 10
        n = n / 10
      end
      kaibun = (nums == nums.reverse)
      r = n_ if kaibun
    end
  end
  r
end
