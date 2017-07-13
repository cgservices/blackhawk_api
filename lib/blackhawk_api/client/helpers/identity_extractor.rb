require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  # Extracts the identity of a Blackhawk object from a resource location.
  class IdentityExtractor
    # Returns a BlackhawkIdentity object from the resource location.
    # @param url The resource location provided by Blackhawk.
    # @return Returns a validated BlackhawkIdentity object.
    def self.to_identity(url)
      if URI(url).query.nil?
        value = URI(url).path.split('/').last.to_s
      else
        value = URI(url).query
      end

      BlackhawkApi::BlackhawkIdentity.new(
        read_identity(value))
    end

    private

    def self.read_identity(str)
      identity_length = 26
      if(identity_length >= str.length)
        str.dup
      else
        str[-identity_length..-1]
      end
    end
  end
end
