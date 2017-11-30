require 'prime'
def euler012
  (1..100000).each do |n|
    sum = (1 + n) * n / 2
    divs = Prime.prime_division(sum)
    div_num = divs.reduce(1){|m,kv| m *= kv[1] + 1 }
    return sum if div_num > 500
  end
  raise
end
