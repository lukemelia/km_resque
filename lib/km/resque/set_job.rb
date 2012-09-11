require 'km/resque/api_client'

module KM
  class Resque
    class SetJob
      @queue = :km

      def self.perform(identifier, properties, timestamp)
        ApiClient.new.set(identifier, properties, timestamp)
      end
    end
  end
end
