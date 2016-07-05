require 'blackhawk_api/version'
require 'httpi'
# require 'httplog'
require 'yaml'
require 'json'

require 'openssl'
require 'base64'
require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/errors/api_error'

module BlackhawkApi
  # Base class for rest resources.
  class RESTResource
    # @@config = BlackhawkApi.config # YAML.load(File.open('./config/bhn_config.certification.yml'))
    @@error_handler = ApiErrorHandler.new

    def self.config
      BlackhawkApi.config || YAML.load(File.open('./config/bhn_config.certification.yml')).with_indifferent_access
    end

    def self.setup_request(uri, request_id = nil, idempotent = false, attempts = 0)
      uri = "#{config.resourcelocation[:base_url]}/#{uri}"
      @request = Request.new(uri)
      setup_authentication
      setup_idempotency(request_id, attempts) if idempotent
      setup_content_types

      @request
    end

    def self.print_response(response)
      json = JSON.parse(response.raw_body)
      puts JSON.pretty_generate(json)
      response
    end

    def self.parse_response(response)
      print_response response
      result = JSON.parse(response.raw_body, object_class: Struct)
      @@error_handler.inspect response, result
      result
    end

    def self.setup_authentication
      @request.auth.ssl.cert_key_file = config.certificate[:key]
      @request.auth.ssl.cert_file = config.certificate[:cert]
      @request.auth.ssl.verify_mode = :peer
      @request.auth.ssl.ssl_version = :TLSv1_2

      @request.headers["requestorId"] = config.identifiers[:requestor_id]
      @request.headers['contractId'] = config.identifiers[:contract_id].to_s
    end

    def self.setup_idempotency(request_id, attempts)
      @request.headers["requestId"] = request_id
      @request.headers["previousAttempts"] = attempts unless attempts == 0
    end

    def self.setup_content_types
      @request.headers['Content-Type'] = 'application/json; charset=UTF-8'
      @request.headers['Accept'] = 'application/json; charset=UTF-8'
    end
  end
end
