require 'nokogiri'

class HtmlParser
  def parse(source_url, body)
    doc = Nokogiri::HTML(body)
    urls = doc.css('a').map { |node|
      att = node.attribute("href")
      att ? att.text : nil }
    normalize(source_url, urls.compact)
  end

  private

  def normalize(source_url, urls)
    urls.map { |u| normalize_url(source_url, u) }.compact
  end

  def normalize_url(source_url, url)
    return nil if url =~ /^#/
    URI.parse(source_url).merge(URI.parse(url)).to_s
  rescue StandardError => ex
    nil
  end
end
