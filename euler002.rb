def fib(n)
  if n <= 1
    n
  else
    fib(n-1) + fib(n-2)
  end
end

def euler002
  fibs = [1,1]
  loop do
    n = fibs[-1] + fibs[-2]
    break if n > 4000_000
    fibs << n
  end

  fibs.select(&:even?).reduce(0){|m,n| m+=n}
end
