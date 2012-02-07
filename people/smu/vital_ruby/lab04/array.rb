class Array
  
  def xeach
    i = 0
    while i < self.size
      yield self[i]
      i += 1
    end
  end
  
  def xmap
    i = 0
    res = []
    while i < self.size
      res[i] = yield self[i]
      i += 1
    end
    res
  end
  
  def xreduce(res = nil)
    i = 0
    while i < self.size
      res = yield res, self[i]
      i += 1
    end
    res
  end
  
end

describe Array do
  
  it "should have an awesome each" do
    a = []
    [1,2,3].xeach { |e| a << e }
    a.should eq([1,2,3])
  end

  it "should have an awesome map" do
    m = [1,2,3].xmap { |e| e ** e }
    m.should eq([1, 4, 27])
  end

  it "should have an awesome reduce" do
    e = [1,2,3].xreduce(0) { |sum, value| sum += value }
    e.should eq(6)
  end
  
end