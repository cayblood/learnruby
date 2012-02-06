require 'test/unit'
require 'read_only_proxy'

class ReadOnlyProxyTest < Test::Unit::TestCase
  class Thing
    attr_accessor :name
  end

  def setup
    super
    @thing = Thing.new
    @thing.name = "THING"
    @ro = ReadOnlyProxy.new(@thing)
  end

  def test_creating_proxy
    assert_not_nil @ro
  end

  def test_normal_methods_pass_thru
    assert_equal "THING", @ro.name
  end

  def test_writing_methods_are_blocked
    @ro.name = "HACKED"
    assert_equal "THING", @thing.name
  end
end
