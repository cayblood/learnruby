class ReadOnlyProxy
  def initialize(target)
    @target = target
  end

  def method_missing(sym, *args, &block)
    if sym.to_s !~ /=$/
      @target.send(sym, *args, &block)
    end
  end
end
