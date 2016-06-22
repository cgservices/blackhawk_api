module BlackhawkApi
  # Represents an error that has occurred in the BlackHawk API.
  class ApiError < RuntimeError
    attr_reader :http_code,
                :error_code,
                :description

    # Initializes a new Error object.
    # @param code The HTTP STATUS code.
    # @param error The error that occurred.
    # @param description A description about the error that occurred.
    def initialize(code, error, description)
      @http_code = code
      @error_code = error
      @description = description
    end

    # Returns a string representation of this error.
    def to_s
      "Error #{@http_code}: #{@error_code} - #{@description}"
    end
  end
end
