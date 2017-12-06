# coding: utf-8
def euler015
  n = 20
  a = [1]
  (n*2).times do |i|
    a = [1] + (0...a.size-1).map{|j| a[j] + a[j+1] } + [1]
  end
  a[a.size/2]
end

def euler015_old
  max = 10
  stack = [[0,0]]
  routes = 0
  while pos = stack.pop
    if pos[0] == max && pos[1] == max
      routes += 1
      next
    end
    if pos[0] <= max
      stack << [pos[0]+1, pos[1]] # 上に移動
    end
    if pos[1] <= max
      stack << [pos[0], pos[1]+1] # 下に移動
    end
  end
  puts routes
  routes
end

