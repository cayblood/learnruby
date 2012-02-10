require "check_links"

describe CheckLinks::UrlFetcher do
  it "fetches urls" do
    fetcher = CheckLinks::UrlFetcher.new
    res = fetcher.fetch "ftp://ftp.powertech.no/test.txt"
    res.should eq("test.txt\n")
  end
  
  it "returns nil on failures" do
    fetcher = CheckLinks::UrlFetcher.new
    res = fetcher.fetch "http://foo.bar/"
    res.should eq(nil)
  end
end

describe CheckLinks::HtmlParser do
  it "parses html and returns empty array when no links exists" do
    parser = CheckLinks::HtmlParser.new
    list = parser.parse("ftp://ftp.powertech.no/test.txt")
    list.size.should eq(0)
  end
  
  it "parses html and returns array when links exists" do
    parser = CheckLinks::HtmlParser.new
    list = parser.parse("http://ulv.no/")

    list.size.should eq(3)    
    list[0].should eq("http://www.sau.no/")
  end

  it "should not return empty hrefs" do
    parser = CheckLinks::HtmlParser.new
    list = parser.parse("http://vg.no/")

    list.each{|e| e.should_not eq(nil)}
  end

  it "should only return absolute paths" do
    parser = CheckLinks::HtmlParser.new
    list = parser.parse("http://vg.no/")
    list.each{|e| e.should include("http") }
  end

end