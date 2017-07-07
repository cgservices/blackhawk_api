require 'blackhawk_api/client/requests/base_request'
require 'httpi'
require 'json'

module BlackhawkApi
  # Basic HTTP client.
  class Client
    # performs a GET request.
    # @param request A request object with headers, parameters etc.
    # @return Returns the raw response.
    def get(request)
      do_request(:get, request)
    end

    # Performs a POST request.
    # @param request A request object with headers, body etc.
    # @return Returns the parsed response.
    def post(request)
      do_request(:post, request)
    end

    # Performs a PUT request.
    # @param request A PUT request object with headers, body etc.
    # @return Returns the parsed response.
    def put(request)
      do_request(:put, request)
    end

    private

    def do_request(method, request)
      begin
        HTTPI.adapter = :net_http
        return HTTPI.send(method, request)
      rescue => e
        namespace = e.class.to_s.split("::").first
        raise BlackhawkApi::ConnectionError, "Connection error performing Blackhawk request: #{e.message}" if namespace == 'Net'
        raise e
      end
    end
  end
end
