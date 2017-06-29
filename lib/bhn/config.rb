module BlackHawkApi
  class Config
    attr_accessor :certificate_file
    attr_accessor :key_file
    attr_accessor :base_endpoint # resourcelocation
    attr_accessor :contract_id
    attr_accessor :requestor_id

    def initialize(options_hash = {})
      options_hash.each {|k,v| public_send("#{k}=",v)}
    end
  end
end