require 'km_resque/api_client'

class KmResque
  class RecordJob
    @queue = :km

    def self.perform(identifier, event_name, properties, timestamp)
      ApiClient.new.record(identifier, event_name, properties, timestamp.to_i)
    end
  end
end
