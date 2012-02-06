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
	attr_accessor :a, :b, :c

	def initialize(a, b, c)
		@a, @b, @c = [a, b, c]
		raise TriangleError unless valid?
	end

	def equilateral?
		a == b && b == c
	end

	def isosceles?
		(a == b || b == c || a == c) && !equilateral?
	end

	def scalene?
		!equilateral? && !isosceles?
	end

	def positive_lengths?
		a > 0 && b > 0 && c > 0
	end

	def valid_lengths?
		sides = [a, b, c]
		sides.sort!
		sides[0] + sides[1] > sides[2]
	end

	def valid?
		positive_lengths? && valid_lengths?
	end

	def greek_name
		[:equilateral, :isosceles, :scalene].each do |t|
			return t if send("#{t}?".to_sym)
		end
	end
end

def triangle(a, b, c)
	t = Triangle.new(a, b, c)
	t.greek_name
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
