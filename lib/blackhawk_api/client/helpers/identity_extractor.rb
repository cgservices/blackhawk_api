require 'blackhawk_api/client/values/blackhawk_identity'
require 'uri'

module BlackhawkApi
  # Extracts the identity of a Blackhawk object from a resource location.
  class IdentityExtractor
    # Returns a BlackhawkIdentity object from the resource location.
    # @param url The resource location provided by Blackhawk.
    # @return Returns a validated BlackhawkIdentity object.
    def self.to_identity(url)
      value = URI(url).path.split('/').last
      BlackhawkApi::BlackhawkIdentity.new(value)
    end
  end
end
