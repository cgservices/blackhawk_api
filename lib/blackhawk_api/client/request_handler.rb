module BlackhawkApi
  module RequestHandler
    attr_reader :last_request_id

    def validate(request)
      validator_class_name = request.class.name.split('::').last + 'Validator'
      validator ||= Object.const_get('BlackhawkApi')
                          .const_get('Validators')
                          .const_get(validator_class_name).new rescue nil

      begin
        validator.validate!(request) unless validator.nil?
      rescue ::Veto::InvalidEntity
        false
      end
      true # Skip validation if no validator or errors are found.
    end

    def inspected(response)
      result = JSON.parse(response.raw_body, object_class: OpenStruct)
      ApiErrorHandler.new._inspect(response, result)
      [response, result]
    end

    def perform(request, &_block)
      return unless validate request

      response = yield

      log(JSON.generate(
        code: response.code,
        headers: response.headers,
        body: response.raw_body.force_encoding("UTF-8")
      ))
      inspected response
    end

    def generate_request_id
      @last_request_id = rand.to_s[2..13]
    end
  end
end
