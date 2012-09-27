require "km_resque/version"
require "km_resque/configuration"
require "km_resque/alias_job"
require "km_resque/set_job"
require "km_resque/record_job"

class KmResque
  class Error < RuntimeError; end
  def self.configure(&block)
    yield configuration
  end
  def self.configuration
    @configuration ||= Configuration.new
  end
  def self.alias(identifier1, identifier2, timestamp=Time.now.to_i)
    ::Resque.enqueue(AliasJob, identifier1, identifier2, timestamp)
  end
  def self.set(identifier, properties, timestamp=Time.now.to_i)
    ::Resque.enqueue(SetJob, identifier, properties, timestamp)
  end
  def self.record(identifier, eventName, properties, timestamp=Time.now.to_i)
    ::Resque.enqueue(RecordJob, identifier, eventName, properties, timestamp)
  end
end
