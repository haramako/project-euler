def collat(n)
  if n.even?
    n / 2
  else
    n * 3 + 1
  end
end

def euler014
  cache = {}
  max = 0
  max_num = 0
  hist = []
  (1..100_0000).map do |num|
    hist.clear
    c = 1
    n = num
    while n != 1
      n = collat(n)
      hist << n
      if cache[n]
        c = c + cache[n]
        break
      end

      c += 1
    end
    # p [num, c, hist]
    hist.each_with_index do |h,i|
      cache[h] = c - i unless cache[h]
    end
    if c > max
      max = c
      max_num = num
      # p [num,c, cache.size]
    end
  end
  max_num
end
