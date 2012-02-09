require 'spec_helper'

describe CheckLinks::UrlFetcher do
  Given(:fetcher) { CheckLinks::UrlFetcher.new }
  context "with good url" do
    Then { fetcher.fetch("http://onestepback.org").should =~ /<html/i }
  end

  context "with bad url path" do
    Then { fetcher.fetch("http://onestepback.org/this_path_does_not_exist").should be_nil }
  end

  context "with bad url host" do
    Then { fetcher.fetch("http://this_host_does_not_exist.com/").should be_nil }
  end

  context "with an ill-formed url" do
    Then { fetcher.fetch("http://no_dot_com").should be_nil }
  end

  context "with an ill-formed protocol" do
    Then { fetcher.fetch("bad_protocol://onestepback.org").should be_nil }
  end
end
