require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  # Identity array which converts multiple strings to valid identity objects.
  class BlackhawkIdentityArray
    attr_reader :ids

    # Initializes a new Blachawk Identity array.
    def initialize(ids = [])
      self.ids = ids
    end

    # Returns a string representation of the identity array.
    def to_s
      ids.map(&:id).join(';')
    end

    protected
    # Assign Blackhawk Identity objects to the identifier array.
    def ids=(value)
      raise ArgumentError, 'No identities specified' if value.nil? || value.empty?
      @ids = if value.respond_to?(:map)
               value.map { |v| BlackhawkIdentity.new(v) }
             else # single value
               [value]
             end
    end
  end
end