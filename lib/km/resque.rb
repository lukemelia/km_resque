require "km/resque/version"
require "km/resque/configuration"
require "km/resque/alias_job"
require "km/resque/set_job"
require "km/resque/record_job"

module KM
  class Resque
    class Error < RuntimeError; end
    def self.configure(&block)
      yield configuration
    end
    def self.configuration
      @configuration ||= Configuration.new
    end
    def self.alias(identifier1, identifier2)
      ::Resque.enqueue(AliasJob, identifier1, identifier2, Time.now.to_i)
    end
    def self.set(identifier, properties)
      ::Resque.enqueue(SetJob, identifier, properties, Time.now.to_i)
    end
    def self.record(identifier, eventName, properties)
      ::Resque.enqueue(RecordJob, identifier, eventName, properties, Time.now.to_i)
    end
  end
end
