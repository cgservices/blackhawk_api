require 'blackhawk_api/client/requests/base_request'
require 'httpi'
require 'json'

module BlackhawkApi
  class Client
    def get request
      HTTPI.get request
    end
    
    def post request
      parse_response HTTPI.post request
    end
    
    def put request
      parse_response HTTPI.put request
    end
    
    private
    def parse_response response
      json = JSON.parse(response.raw_body)
      puts JSON.pretty_generate(json)
      return JSON.parse(response.raw_body, object_class: OpenStruct)
    end
  end
end