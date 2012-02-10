require 'spec_helper'

describe HtmlParser do
  Given(:parser) { HtmlParser.new }
  Given(:html) { "" }
  Given(:source) { "http://x.com/" }

  Given(:url) { "http://x.com/" }
  Given(:urls) { [url] }
  Given(:anchors) { urls.map { |u| %(<a href="#{u}">Link</a>) } }

  Given(:html) {
    "<html><body><h1>HI</h1>" +
    anchors.join +
    "</body></html>"
  }

  When(:result) { parser.parse(source, html) }

  context "with an empty body" do
    Given(:html) { "" }
    Then { result.should == [] }
  end

  context "with no links" do
    Given(:html) { "<html><body><h1>HI</h1></body></html>" }
    Then { result.should == [] }
  end

  context "with a single link" do
    Then { result.should == ["http://x.com/"] }
  end

  context "with multiple link" do
    Given(:urls) { ["http://x.com", "http://x.com/b" ] }
    Then { result.should == urls }
  end

  context "with path-link links" do
    Given(:urls) { ["/a", "b", "./c"] }
    Then { result.should == ["http://x.com/a", "http://x.com/b", "http://x.com/c"] }
  end

  context "with off-site links" do
    Given(:source) { "http://x.com/page" }
    Given(:url) { "http://z.com/index.html" }
    Then { result.should == ["http://z.com/index.html"] }
  end

  context "with non-html links" do
    Given(:urls) { ["mailto://x@z.com", "http://x.com/"] }
    Then { result.should == ["http://x.com/"] }
  end

  context "with hash pieces links" do
    Given(:urls) { ["#hash", "http://x.com/"] }
    Then { result.should == ["http://x.com/"] }
  end

  context "with a bad URI" do
    Given(:source) { "http://x.com/page" }
    Given(:urls) {  [ "a\nb", "b" ] }
    Then { result.should == ["http://x.com/b"] }
  end
end
