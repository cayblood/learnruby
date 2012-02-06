class Wondrous

  attr_accessor :cache
  attr_accessor :counter

  def initialize(use_cache = true)
    @use_cache = use_cache
    @counter = 0
    @cache = {}
  end

  def wondrous(num, list = [])
    if (@use_cache && cache[num])
      list.concat(cache[num])
    else
      @counter += 1
      list << num

      if num > 1
        if num % 2 == 0
          wondrous num / 2, list
        else
          wondrous num * 3 + 1, list
        end
      end

      cache[num] = list
    end
  end

end