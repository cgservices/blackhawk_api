require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  # Value object to encapsulate Blackhawk's identity model.
  class BlackhawkIdentity
    attr_reader :id

    # Initializes a new identity value.
    # @param identity A string representation of the identity value.
    def initialize(identity)
      self.id = identity
    end

    # Returns the string representation of this identity value.
    def to_s
      id
    end

    protected

    def id=(value)
      raise ArgumentError, 'No identity specified' if value.nil? || value.empty?
      raise ArgumentError, 'Invalid identity specified' if value.length > 26
      @id = value
    end
  end

  # Identity array which converts multiple strings to valid identity objects.
  class BlackhawkIdentityArray
    attr_reader :ids

    def initialize(ids)
      self.ids = ids
    end

    def to_s
      ids.map(&:id).join(';')
    end

    protected

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
