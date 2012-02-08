class Presentation
  attr_accessor :title, :presenter
  
  def initialize title, presenter
    @title = title
    @presenter = presenter
  end
  
end

class Proxy
  
  def initialize proxied
    @proxied = proxied
  end
  
  def method_missing(name, *args, &block)
    unless /=$/ =~ name
      @proxied.send(name, *args, &block)
    end
  end
  
end

class ShadowProxy
  
  def initialize proxied
    @proxied = proxied
    @cache = {}
  end
  
  def method_missing(name, *args, &block)
    if /=$/ =~ name
      @cache[name.to_s.chop] = args.first
    elsif @cache.has_key?(name.to_s)
      @cache[name.to_s]
    else 
      @proxied.send(name, *args, &block)
    end
  end

end

describe Proxy do
  
  it "object should be modifiable" do
    p = Presentation.new "foo", "bar"
    
    p.title.should eq("foo")
    
    p.title = "bar"
    p.title.should eq("bar")
  end

  it "proxy object should not be modifiable" do
    p = Presentation.new "foo", "bar"

    px = Proxy.new(p)
    px.title.should eq("foo")
    
    px.title = "bar"
    px.title.should eq("foo")
  end

  it "shadowed proxy object should be be modifiable, but keep existing" do
    p = Presentation.new "foo", "bar"

    px = ShadowProxy.new p
    px.title.should eq("foo")
    px.title = "bar"
    px.title.should eq("bar")
    
    p.title.should eq("foo")
  end


end