require "open-uri"

module CheckLinks
  class UrlFetcher
    def fetch(url)
      open(url){ |stream| stream.read } rescue nil
    end
  end
end