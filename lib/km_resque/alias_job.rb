require 'km_resque/api_client'

class KmResque
  class AliasJob
    @queue = :km

    def self.perform(identifier1, identifier2, timestamp)
      ApiClient.new.alias(identifier1, identifier2, timestamp.to_i)
    end
  end
end
