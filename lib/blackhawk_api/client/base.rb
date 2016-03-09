require "blackhawk_api/version"
require 'httpi-ntlm'
require 'inifile'

module BlackhawkApi
  class Client
    REQUESTOR_ID = "ZPZB7DDS20PNHALMZCBX14RVCM"
    
    def initialize(args)
      # config = IniFile.new("../config.ini")
      # @request = HTTPI::Request.new(config["request"]["uri"])
      
      # if args.include?("-p")
      #   if args.include?("-n")
      #     @request.auth.ntlm(
      #       config["proxysettings"]["proxy_userName"], config["proxysettings"]["proxy_password"])
      #   end
      #   if args.include?("-u")
      #     @request.auth.basic(
      #       config["proxysettings"]["proxy_userName"], config["proxysettings"]["proxy_password"])
      #   end
      # end
      # @request.auth.ssl.cert_key_file = config["certificate"]["pem_key"]
      # @request.auth.sll.cert_file = config["certificate"]["pem_cert"]
      # @request.headers["requestorId"] = REQUESTOR_ID
      # @request.headers["Content-Type"] = "application/json; charset=UTF-8"
      # @request.headers["Accept"] = "application/json; charset=UTF-8"
      puts 'OK!'
    end
    
    def get
      @response = HTTPI.get @request
    end
    
    def delete
      @response = HTTPI.delete @request
    end
    
    def post body
      @request.body = body
      @response = HTTPI.post @request
    end
    
    def put body
      @request.body = body
      @response = HTTPI.put @request
    end
  end
end
