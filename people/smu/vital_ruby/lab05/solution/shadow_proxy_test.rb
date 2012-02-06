require 'test/unit'
require 'shadow_proxy'

class ShadowProxyTest < Test::Unit::TestCase
  class Thing
    attr_accessor :name
  end

  def setup
    super
    @thing = Thing.new
    @thing.name = "THING"
    @sh = ShadowProxy.new(@thing)
  end

  def test_creating_proxy
    assert_not_nil @sh
  end

  def test_normal_methods_pass_thru
    assert_equal "THING", @sh.name
  end

  def test_writing_methods_are_blocked
    @sh.name = "HACKED"
    assert_equal "THING", @thing.name
  end

  def test_writing_methods_are_shadowed
    @sh.name = "HACKED"
    assert_equal "HACKED", @sh.name
  end

end
