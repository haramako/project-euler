EULER_017_NUM = %w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
EULER_017_NUM_TEN = %w(zero ten twenty thirty forty fifty sixty seventy eighty ninety)

def human_num(n)
  if n == 1000
    return ['one', 'thousand']
  end
  
  r = []
  hundred = n / 100
  rest = n % 100
  if hundred > 0
    r = r + human_num(hundred)
    r << 'hundred'
    if rest != 0
      r << 'and'
    end
  end
  
  if rest > 0
    if EULER_017_NUM[rest]
      r << EULER_017_NUM[rest]
    else
      r << EULER_017_NUM_TEN[rest/10] if rest / 10 != 0
      r << EULER_017_NUM[rest%10] if rest % 10 != 0
    end
  end
  r
end

def euler017
  lens = (1..1000).map do |n|
    human_num(n).join.size
  end
  lens.reduce(0){|m,n| m += n }
end
