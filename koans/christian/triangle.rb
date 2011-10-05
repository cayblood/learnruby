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
  if is_equilateral a, b, c
    result = :equilateral
  elsif is_isosceles a, b, c
    result = :isosceles
  elsif is_scalene a, b, c
    result = :scalene
  end
end

def is_equilateral(a, b, c)
  a == b and b == c
end

def is_isosceles(a, b, c)
  a == b or b == c or a == c
end

def is_scalene(a, b, c)
  a != b and b != c and c != a
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
