$:.push File.expand_path('../../lib', __FILE__)
require 'webmock/rspec'
require 'km_resque/record_job'

describe "KmResque::RecordJob" do
  before(:each) do
    stub_request(:any, %r{http://trk.kissmetrics.com.*})
    KmResque.configure do |config|
      config.key = "abc123"
    end
  end
  describe "perform" do
    it "should hit the KM API" do
      timestamp = Time.now.to_i
      KmResque::RecordJob.perform("identifier", "eventName", { :foo => 'bar', :baz => 'bay'}, timestamp)
      expected_api_hit = "http://trk.kissmetrics.com/e?_d=1&_k=abc123&_n=eventName&_p=identifier&_t=#{timestamp}&baz=bay&foo=bar"
      WebMock.should have_requested(:get, expected_api_hit)
    end
    it "should succceed with no properties" do
      timestamp = Time.now.to_i
      KmResque::RecordJob.perform("identifier", "eventName", nil, timestamp)
      expected_api_hit = "http://trk.kissmetrics.com/e?_d=1&_k=abc123&_n=eventName&_p=identifier&_t=#{timestamp}"
      WebMock.should have_requested(:get, expected_api_hit)
    end
    it "should raise an error when no identity is provided" do
      timestamp = Time.now.to_i
      lambda {
        KmResque::RecordJob.perform(nil, "eventName", { :foo => 'bar', :baz => 'bay'}, timestamp)
        }.should raise_error(KmResque::Error)
    end
    it "should raise an error when an invalid timestamp is provided" do
      timestamp = Time.now.to_i * 1000 # common mistake is providing milliseconds instead of seconds
      lambda {
        KmResque::RecordJob.perform("identifier", "eventName", { :foo => 'bar', :baz => 'bay'}, timestamp)
        }.should raise_error(KmResque::Error)
    end
  end
end
