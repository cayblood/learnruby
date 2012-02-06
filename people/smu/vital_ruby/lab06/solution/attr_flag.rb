class Module
  def attr_flag(*names)
    names.each do |name|
      module_eval "def #{name}?(); @#{name}; end"
    end
  end
end
