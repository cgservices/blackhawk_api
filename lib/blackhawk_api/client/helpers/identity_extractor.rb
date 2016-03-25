require 'blackhawk_api/client/values/blackhawk_identity'
require 'uri'

module BlackhawkApi
  class IdentityExtractor
    def self.to_identity(url)
      value = URI(url).path.split('/').last
      return BlackhawkApi::BlackhawkIdentity.new(value)
    end
  end
end 