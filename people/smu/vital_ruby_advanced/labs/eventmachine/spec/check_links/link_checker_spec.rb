require 'spec_helper'

describe CheckLinks::LinkChecker do
  Given(:link_map) { { } }
  Given(:parser) { FauxParser.new }
  Given(:fetcher) { FauxFetcher.new(link_map) }

  Given(:checker) {
    CheckLinks::LinkChecker.new(parser: parser, fetcher: fetcher)
  }

  context "initial values" do
    Then { checker.should_not be_nil }
    Then { checker.bad_urls.should be_empty }
  end

  describe "running the checker" do
    Given(:root_url) { "http://xyz.com/" }
    Given(:prefix) { nil }
    Given { checker.check(root_url, prefix) }

    context "with no links on the initial page" do
      Given(:link_map) {
        { "http://xyz.com/" => [ ] }
      }
      Then { checker.bad_urls.should contain_urls() }
      Then { checker.good_urls.should contain_urls("http://xyz.com/") }
    end

    context "with two good links" do
      Given(:link_map) {
        {
          "http://xyz.com/" => [ "http://xyz.com/a", "http://xyz.com/b" ],
          "http://xyz.com/a" => [ ],
          "http://xyz.com/b" => [ ],
        }
      }
      Then { checker.bad_urls.should contain_urls() }
      Then {
        checker.good_urls.should contain_urls(
          "http://xyz.com/",
          "http://xyz.com/a",
          "http://xyz.com/b")
      }
    end

    context "with one bad links" do
      Given(:link_map) {
        {
          "http://xyz.com/" => [ "http://xyz.com/a", "http://xyz.com/bad" ],
          "http://xyz.com/a" => [ ],
        }
      }
      Then { checker.bad_urls.should contain_urls("http://xyz.com/bad") }
      Then {
        checker.good_urls.should contain_urls(
          "http://xyz.com/",
          "http://xyz.com/a")
      }
    end

    context "with nested links" do
      Given(:link_map) {
        {
          "http://xyz.com/" => [ "http://xyz.com/a", "http://xyz.com/b" ],
          "http://xyz.com/a" => [ ],
          "http://xyz.com/b" => [ "http://xyz.com/b_sub" ],
          "http://xyz.com/b_sub" => [ ],
        }
      }
      Then { checker.bad_urls.should contain_urls() }
      Then {
        checker.good_urls.should contain_urls(
          "http://xyz.com/",
          "http://xyz.com/a",
          "http://xyz.com/b",
          "http://xyz.com/b_sub")
      }
    end

    context "with outside links" do
      Given(:link_map) {
        {
          "http://xyz.com/" => [ "http://xyz.com/a", "http://xyz.com/b" ],
          "http://xyz.com/a" => [ ],
          "http://xyz.com/b" => [ "http://outside.com/" ],
          "http://outside.com/" => [ "http://outside.com/a" ],
          "http://outside.com/a" => [ "http://outside.com/other" ],
        }
      }
      Then { checker.bad_urls.should contain_urls() }
      Then {
        checker.good_urls.should contain_urls(
          "http://xyz.com/",
          "http://xyz.com/a",
          "http://xyz.com/b",
          "http://outside.com/")
      }
    end

    context "with outside links and a explicit prefix" do
      Given(:prefix) { "http://xyz.com/page" }
      Given(:root_url) { "http://xyz.com/page/index.html" }
      Given(:link_map) {
        {
          "http://xyz.com/page/index.html" => [
            "http://xyz.com/off",
            "http://xyz.com/page/on"
          ],
          "http://xyz.com/off" => [ "http://xyz.com/a" ],
          "http://xyz.com/page/on" => [ "http://xyz.com/b" ],
          "http://xyz.com/b" => [ ],
        }
      }
      Then { checker.bad_urls.should contain_urls() }
      Then {
        checker.good_urls.should contain_urls(
          "http://xyz.com/page/index.html",
          "http://xyz.com/off",
          "http://xyz.com/page/on",
          "http://xyz.com/b")
      }
    end

    context "with duplicate links" do
      Given(:link_map) {
        {
          "http://xyz.com/" => [ "http://xyz.com/a", "http://xyz.com/b" ],
          "http://xyz.com/a" => [ "http://xyz.com/dup" ],
          "http://xyz.com/b" => [ "http://xyz.com/dup" ],
          "http://xyz.com/dup" => [ "http://xyz.com/dup2" ],
          "http://xyz.com/dup2" => [ ],
        }
      }
      Then { checker.bad_urls.should contain_urls() }
      Then {
        checker.good_urls.should contain_urls(
          "http://xyz.com/",
          "http://xyz.com/a",
          "http://xyz.com/b",
          "http://xyz.com/dup",
          "http://xyz.com/dup2")
      }
    end

    context "with circular dependencies" do
      Given(:link_map) {
        {
          "http://xyz.com/" => [ "http://xyz.com/a", "http://xyz.com/b" ],
          "http://xyz.com/a" => [ "http://xyz.com/b" ],
          "http://xyz.com/b" => [ "http://xyz.com/a" ],
        }
      }
      Then { checker.bad_urls.should contain_urls() }
      Then {
        checker.good_urls.should contain_urls(
          "http://xyz.com/",
          "http://xyz.com/a",
          "http://xyz.com/b")
      }
    end

  end
end
