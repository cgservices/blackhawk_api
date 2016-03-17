require "blackhawk_api/version"
require 'httpi'
require 'json'

module BlackhawkApi
  # Base class for BlackHawk requests.
  class Request < HTTPI::Request
    # attr_reader :page_size, :page_index, :sort_key
    
    def self.create(url)
      request = self.new(url)
      request
    end
    
    def skip items
      self.query = { :first => items }.merge(CGI::parse(self.query))
      return self
    end
    
    def take count
      self.query = { :maximum => count }.merge(CGI::parse(self.query))      
      return self
    end
    
    def orderby sortkey, ascending = true
      self.query = { :sortKey => sortkey, :ascending => ascending }
        .merge(CGI::parse(self.query))
      return self
    end
    
    def paginate request
      return self
        .skip(request.page_index * request.page_size)
        .take(request.page_size)
        .orderby(request.sort_key)
    end
    
    protected
    def initialize(url)
      super(url)
    end
  end
  
  # Base class for pagination support for BlackHawk requests.
  class PaginatedRequest < Request
    def initialize(sort_key, page_index, page_size)
      super(sort_key, page_index, page_size)
    end
  end
end