if ARGV.size != 1
  puts 'gimme one argument'
  return
end

def wondrous?(num)
  if num != 1
    if num % 2 == 0
      wondrous? num / 2
    else
      wondrous? num * 3 + 1
    end
  end
  return true
end

puts wondrous? ARGV[0].to_i