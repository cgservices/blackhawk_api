require "blackhawk_api/version"
require 'httpi'
require 'yaml'
require 'pry'
require 'json'

require 'openssl'
require 'base64'
require 'active_resource'

module BlackhawkApi
  class RESTResource
    @@config = YAML.load(File.open("./config/config.yml"))
    REQUESTOR_ID = "ZPZB7DDS20PNHALMZCBX14RVCM"
    CONTRACT_ID = ""
    @@error_handler = ApiErrorHandler.new
  
    def self.setup_request uri
      uri = "#{@@config['resourcelocation']['base_url']}/#{uri}"
    
      @request = HTTPI::Request.new(uri)
      setup_authentication
      setup_idempotency
      setup_content_types
      
      @request
    end
    
    def self.print_response response
      json = JSON.parse(response.raw_body)
      puts JSON.pretty_generate(json)
      response
    end
    
    def self.parse_response response
      print_response response
      result = JSON.parse(response.raw_body, object_class: OpenStruct)
      @@error_handler.inspect response, result
      result
    end
    
    protected
    def self.default_pagination
      return { :ascending => ascending, :first => first, :maximum => maximum }
    end
    
    private
    def self.setup_authentication
      @request.auth.ssl.cert_key_file = @@config["certificate"]["key"]
      @request.auth.ssl.cert_file = @@config["certificate"]["cert"]
      @request.auth.ssl.verify_mode = :peer
      @request.auth.ssl.ssl_version = :TLSv1_2
    end
    
    def self.setup_idempotency
      # @request.headers["requestorId"] = REQUESTOR_ID
      # @request.headers["requestId"] = REQUEST_ID
      # @request.headers["previousAttempts"] = PREVIOUS_ATTEMPTS
    end
    
    def self.setup_content_types
      @request.headers["Content-Type"] = "application/json; charset=UTF-8"
      @request.headers["Accept"] = "application/json; charset=UTF-8"
    end
  end
end
