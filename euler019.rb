def euler019
  n = 0
  d = Time.new(1901,1,1)
  d_max = Time.new(2001,1,1)
  while d < d_max
    d += 60 * 60 * 24
    if d.day == 1 && d.wday == 0
      n += 1
      # puts d
    end
  end
  n
end
