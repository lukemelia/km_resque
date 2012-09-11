require 'km/resque/api_client'

module KM
  class Resque
    class AliasJob
      @queue = :km

      def self.perform(identifier1, identifier2, timestamp)
        ApiClient.new.alias(identifier1, identifier2, timestamp)
      end
    end
  end
end
