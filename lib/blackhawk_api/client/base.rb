require 'blackhawk_api/version'
require 'httpi'
require 'yaml'
require 'json'

require 'openssl'
require 'base64'
require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/errors/blackhawk_api_error'

module BlackhawkApi
  # Base class for rest resources.
  class RESTResource
    @@config = YAML.load(File.open('./config/bhn_config.certification.yml'))
    REQUESTOR_ID = "ZPZB7DDS20PNHALMZCBX14RVCM"
    CONTRACT_ID = "7JAC21WTR6X" #SRAGNHRL1XDZ2PC"
    @@error_handler = ApiErrorHandler.new

    def self.setup_request(uri)
      uri = "#{@@config['resourcelocation']['base_url']}/#{uri}"
      @request = Request.new(uri)
      setup_authentication
      setup_idempotency
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
      @request.auth.ssl.cert_key_file = @@config['certificate']['key']
      @request.auth.ssl.cert_file = @@config['certificate']['cert']
      @request.auth.ssl.verify_mode = :peer
      @request.auth.ssl.ssl_version = :TLSv1_2
    end

    def self.setup_idempotency
      # @request.headers["requestorId"] = REQUESTOR_ID
      # @request.headers["requestId"] = REQUEST_ID
      # @request.headers["previousAttempts"] = PREVIOUS_ATTEMPTS
    end

    def self.setup_content_types
      @request.headers['Content-Type'] = 'application/json; charset=UTF-8'
      @request.headers['Accept'] = 'application/json; charset=UTF-8'
    end
  end
end
