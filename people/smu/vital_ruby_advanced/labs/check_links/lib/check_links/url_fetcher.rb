require 'open-uri'

module CheckLinks
  class UrlFetcher
    def fetch(url)
      open(url) { |f| f.read }
    rescue StandardError => ex
      nil
    end
  end
end
