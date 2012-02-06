
# BeWithin is an intermediate class that is used by the be_within
# method to capture the tolerance that is later applied to expected
# value.
#
class BeWithin

  # Matcher returned from the +of+ method of the BeWithin class.
  class Matcher
    def initialize(expected, tolerance)
      @tolerance = tolerance
      @expected = expected
    end

    def matches?(actual)
      @actual = actual
      (@expected-@actual).abs <= @tolerance
    end

    def failure_message_for_should
      "Expected the difference of <#{@actual}> and " +
        "<#{@expected}> to be <= #{@tolerance}, " +
        "difference was #{(@expected-@actual).abs}"
    end

    def failure_message_for_should_not
      "Expected the difference of <#{@actual}> and " +
        "<#{@expected}> to be > #{@tolerance}, " +
        "difference was #{(@expected-@actual).abs}"
    end
  end

  # Create a BeWithin instance to hold the tolerance.
  def initialize(tolerance)
    @tolerance = tolerance
  end

  # Create an RSpec matcher that checks for the absolute difference
  # between the expected and actual values to be less than the given
  # tolerance.
  def of(expected)
    BeWithin::Matcher.new(expected, @tolerance)
  end
end

module Spec
  module Matchers
    # be_within mimics the be_within matcher available in RSpec 2.0.
    # This matcher passes if the absolute difference between the
    # expected and actual values are less than or equal to the
    # tolerance.
    #
    # Usage:
    #   actual_value.should be_within(tolerance).of(expected_value)
    #
    def be_within(tolerance)
      BeWithin.new(tolerance)
    end
  end
end
