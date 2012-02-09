require 'eventmachine'
require 'em-http'

module CheckLinks
  class EmFetcher
    def initialize(timeout=30)
      @outstanding = 0
      @timeout = timeout
    end

    def fetch(url, &block)
      @outstanding += 1

      http = EventMachine::HttpRequest.new(url).get(timeout: @timeout, redirects: 1)
      http.errback do
        @outstanding -= 1
        block.call(nil)
      end

      http.callback do
        @outstanding -= 1
        if http.response_header.status == 200
          block.call(http.response)
        else
          block.call(nil)
        end
      end
    end

    def busy?
      @outstanding > 0
    end
  end
end
