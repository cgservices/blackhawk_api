require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/errors/api_error'

module BlackhawkApi
  # Base class for rest resources.
  class RESTResource
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def setup_request(uri, request_id = nil, idempotent = false, attempts = 0)
      @request = Request.new("#{config.resourcelocation[:base_url]}/#{uri}")
      setup_authentication
      setup_idempotency(request_id, attempts) if idempotent
      setup_content_types

      @request
    end

    def parse_response(response)
      print_response response
      result = JSON.parse(response.raw_body, object_class: Struct)
      ApiErrorHandler.new.inspect response, result
      result
    end

    private

    def print_response(response)
      json = JSON.parse(response.raw_body)
      puts JSON.pretty_generate(json)
      response
    end

    def setup_authentication
      @request.auth.ssl.cert_key_file = config.certificate[:key]
      @request.auth.ssl.cert_file = config.certificate[:cert]
      @request.auth.ssl.verify_mode = :peer
      @request.auth.ssl.ssl_version = :TLSv1_2
      @request.open_timeout = 5 # seconds
      @request.read_timeout = 30 # seconds

      @request.headers["requestorId"] = config.identifiers[:requestor_id]
      @request.headers['contractId'] = config.identifiers[:contract_id].to_s
    end

    def setup_idempotency(request_id, attempts)
      @request.headers["requestId"] = request_id
      @request.headers["previousAttempts"] = attempts unless attempts == 0
    end

    def setup_content_types
      @request.headers['Content-Type'] = 'application/json; charset=UTF-8'
      @request.headers['Accept'] = 'application/json; charset=UTF-8'
    end
  end
end
