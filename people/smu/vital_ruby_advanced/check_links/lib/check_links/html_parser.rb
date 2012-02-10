require "nokogiri"
require "check_links/url_fetcher"

module CheckLinks
  class HtmlParser
    def parse url, html = nil
      html ||= CheckLinks::UrlFetcher.new.fetch url
      Nokogiri::HTML(html).css('a').map{|e| parse_url(url, get_href(e)) }.compact
    end
  
    def get_href e
      e.attribute("href") rescue nil
    end
  
    def parse_url base, url
      unless /^#/ =~ url
        URI.parse(base).merge(URI.parse(url)).to_s rescue nil
      end
    end  
  end
end