require 'eventmachine'

module CheckLinks
  class LinkChecker
    attr_reader :good_urls, :bad_urls

    def initialize(options={})
      @fetcher = options[:fetcher] || CheckLinks::UrlFetcher.new
      @parser  = options[:parser]  || CheckLinks::HtmlParser.new
      @good_urls = []
      @bad_urls = []
      @seen = {}
      @prefix = nil
    end

    # %+ runloop
    def check(url, prefix=nil)
      prefix ||= url
      @prefix = Regexp.new("^" + Regexp.quote(prefix))
      EventMachine.run do
        check_url(url)
      end
    end
    # %-

    private

    # %+ checkurl
    def check_url(url)
      return if seen?(url)
      mark_seen(url)
      @fetcher.fetch(url) do |body|
        if body.nil?
          @bad_urls << url
        else
          @good_urls << url
          if has_prefix?(url)
            new_urls = @parser.parse(url, body)
            check_urls(new_urls)
          end
        end
        EventMachine.stop unless @fetcher.busy?
      end
    end
    # %-

    def check_urls(urls)
      urls.each do |url| check_url(url) end
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

