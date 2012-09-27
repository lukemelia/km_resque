require 'km_resque/api_client'

class KmResque
  class SetJob
    @queue = :km

    def self.perform(identifier, properties, timestamp)
      ApiClient.new.set(identifier, properties, timestamp.to_i)
    end
  end
end
