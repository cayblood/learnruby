require 'test/unit'
require 'attr_flag'

class AttrFlagTest < Test::Unit::TestCase
  class X
    attr_accessor :ok
    attr_flag :ok
    attr_flag :a, :b, :c

    def initialize
      @a = @b = @c = true
    end
  end

  def test_flag_is_true
    x = X.new
    x.ok = true
    assert x.ok?
  end

  def test_flag_is_false
    x = X.new
    x.ok = false
    assert ! x.ok?
  end

  def test_defines_multiple_names
    x = X.new
    assert x.a?
    assert x.b?
    assert x.c?
  end
end
