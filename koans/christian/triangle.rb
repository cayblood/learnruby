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

class Triangle
  def initialize(a, b, c)
    @sides = [a, b, c].sort
    @num_unique_sides = @sides.uniq.size
  end

  def get_triangle_type
    if not valid?
      raise TriangleError
    end

    get_triangle_symbols
  end

  def valid?
    @sides[0] + @sides[1] > @sides[2]
  end

  def get_triangle_symbols
    if equilateral?
      :equilateral
    elsif isosceles?
      :isosceles
    else
      :scalene
    end
  end

  def equilateral?
    @num_unique_sides == 1
  end

  def isosceles?
    @num_unique_sides == 2
  end
end

def triangle(a, b, c)
  Triangle.new(a, b, c).get_triangle_type
end

class TriangleError < StandardError
end

