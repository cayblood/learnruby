require 'rspec/given'
require 'check_links'


class FauxFetcher
  def initialize(mapping)
    @mapping = mapping
  end

  def fetch(url)
    yield(@mapping[url])
  end

  def busy?
    false
  end
end

class FauxParser
  def parse(source_url, body)
    body
  end
end

module RSpec::Matchers
  matcher :contain_urls do |*expected_urls|
    match do |actual_urls|
      actual_urls.sort == expected_urls.sort
    end

    failure_message_for_should do |actual_urls|
      extra = diff(actual_urls, expected_urls)
      missing = diff(expected_urls, actual_urls)
      "URL lists do not match\n" +
        "Expected: #{expected_urls.inspect}\n" +
        "Got:      #{actual_urls.inspect}\n" +
        "Missing:  #{missing.inspect}\n" +
        "Extra:    #{extra.inspect}"
    end

    failure_message_for_should_not do |expected|
      fail "should_not not implemented for contains_urls"
    end
  end

  def diff(a,b)
    b_counts = count(b)
    count(a).map { |item, n|
      c = n - b_counts[item]
      c = 0 if c < 0
      [item] * c
    }.flatten.sort
  end

  def count(ary)
    result = Hash.new(0)
    ary.each do |item|
      result[item] += 1
    end
    result
  end
end
