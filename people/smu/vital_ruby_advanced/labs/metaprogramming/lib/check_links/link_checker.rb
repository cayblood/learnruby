module CheckLinks
  class LinkChecker
    attr_reader :good_urls, :bad_urls

    def initialize(options={})
      @fetcher = options[:fetcher] || CheckLinks::UrlFetcher.new
      @parser  = options[:parser]  || CheckLinks::HtmlParser.new
      @good_urls = []
      @bad_urls = []
      @unchecked_urls = []
      @seen = {}
      @prefix = nil
    end

    def check(url, prefix=nil)
      prefix ||= url
      @prefix = Regexp.new("^" + Regexp.quote(prefix))
      add_url(url)
      run
    end

    private

    def run
      while ! @unchecked_urls.empty?
        url = @unchecked_urls.pop
        next if seen?(url)
        mark_seen(url)
        body = fetch(url)
        if body.nil?
          @bad_urls << url
        else
          @good_urls << url
          if has_prefix?(url)
            new_urls = parse(url, body)
            add_urls(new_urls)
          end
        end
      end
    end

    def add_url(url)
      @unchecked_urls << url
    end

    def add_urls(urls)
      urls.each do |url| add_url(url) end
    end

    def fetch(url)
      @fetcher.fetch(url)
    end

    def parse(url, body)
      @parser.parse(url, body)
    end

    def has_prefix?(url)
      @prefix && @prefix.match(url)
    end

    def seen?(url)
      @seen[url]
    end

    def mark_seen(url)
      @seen[url] = true
    end
  end
end

