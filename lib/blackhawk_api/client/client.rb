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
      HTTPI.post request
    end

    # Performs a PUT request.
    # @param request A PUT request object with headers, body etc.
    # @return Returns the parsed response.
    def put(request)
      HTTPI.put request
    end
  end
end
