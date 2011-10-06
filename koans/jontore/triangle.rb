# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  arr = [a, b, c]
  puts 
  if checkLengths(arr.dup) || arr.any? {|x| x < 1} 
    raise TriangleError, 'That was wrong biatch'
  end
  uni = arr.uniq!
  return :scalene unless uni
  case uni.length 
    when 1
      :equilateral
    when 2
      :isosceles
  end
end

def checkLengths(arr)
  base = arr.max
  arr.slice!(arr.index(base))
  sum = arr.inject{|sum, x| sum + x }
  sum && sum <= base
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
