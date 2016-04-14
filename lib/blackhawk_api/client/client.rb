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
      HTTPI.get request
    end

    # Performs a POST request.
    # @param request A request object with headers, body etc.
    # @return Returns the parsed response.
    def post(request)
      parse_response HTTPI.post request
    end

    # Performs a PUT request.
    # @param request A PUT request object with headers, body etc.
    # @return Returns the parsed response.
    def put(request)
      parse_response HTTPI.put request
    end

    private

    def parse_response(response)
      json = JSON.parse(response.raw_body)
      puts JSON.pretty_generate(json)
      JSON.parse(response.raw_body, object_class: OpenStruct)
    end
  end
end
