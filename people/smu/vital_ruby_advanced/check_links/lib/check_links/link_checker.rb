module CheckLinks
  class LinkChecker
    
    attr_accessor :bad_urls, :good_urls
    
    def initialize(options)
      @queue = []
      @bad_urls = []
      @good_urls = []
      
      @parser = options[:parser]
      @fetcher = options[:fetcher]
    end
    
    def check(root_url, prefix)
      @queue << root_url
      process_queue(prefix);
    end
    
    def process_queue(prefix)
      link = @queue.pop
      if link
        html = @fetcher.fetch(link)
        if html
          @good_urls << link
          get_links(html, prefix)
        else
          @bad_urls << link
        end
        process_queue(prefix)
      end
    end

    def get_links(html, prefix)
      links = @parser.parse(html, prefix)
      if links
        @queue.concat links
      end
    end

  end
end