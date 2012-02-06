class ShadowProxy
  def initialize(target)
    @target = target
    @shadow = {}
  end

  def method_missing(sym, *args, &block)
    name = sym.to_s
    if sym.to_s =~ /=$/
      name.gsub!(/=$/,'')
      @shadow[name] = args.first
    elsif @shadow.has_key?(name)
      @shadow[name]
    else
      @target.send(sym, *args, &block)
    end
  end
end
