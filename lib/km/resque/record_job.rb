require 'km/resque/api_client'

module KM
  class Resque
    class RecordJob
      @queue = :km

      def self.perform(identifier, event_name, properties, timestamp)
        ApiClient.new.record(identifier, event_name, properties, timestamp)
      end
    end
  end
end
