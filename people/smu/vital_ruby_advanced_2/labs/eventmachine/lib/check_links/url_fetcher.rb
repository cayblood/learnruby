require 'open-uri'

module CheckLinks
  class UrlFetcher
    def fetch(url, &block)
      body = open(url) { |f| f.read }
      block.call(body)
    rescue StandardError => ex
      block.call(nil)
    end
  end
end
