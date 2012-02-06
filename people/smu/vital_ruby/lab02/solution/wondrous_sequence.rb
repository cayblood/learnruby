CACHE = {}

def wondrous_sequence(n)
  result = []
  i = n
  loop do
    if CACHE[i]
      result += CACHE[i]
      break
    end
    result << i
    break if i == 1
    if (i%2) == 0
      i = i/2
    else
      i = 3*i + 1
    end
  end
  CACHE[n] = result
  result
end
