$:.push File.expand_path('../../lib', __FILE__)
require 'webmock/rspec'
require 'km/resque/record_job'

describe "KM::Resque::RecordJob" do
  before(:each) do
    stub_request(:any, %r{http://trk.kissmetrics.com.*})
    KM::Resque.configure do |config|
      config.key = "abc123"
    end
  end
  describe "perform" do
    it "should hit the KM API" do
      timestamp = Time.now.to_i
      KM::Resque::RecordJob.perform("identifier", "eventName", { :foo => 'bar', :baz => 'bay'}, timestamp)
      expected_api_hit = "http://trk.kissmetrics.com/e?_d=1&_k=abc123&_n=eventName&_p=identifier&_t=#{timestamp}&baz=bay&foo=bar"
      WebMock.should have_requested(:get, expected_api_hit)
    end
    it "should succceed with no properties" do
      timestamp = Time.now.to_i
      KM::Resque::RecordJob.perform("identifier", "eventName", nil, timestamp)
      expected_api_hit = "http://trk.kissmetrics.com/e?_d=1&_k=abc123&_n=eventName&_p=identifier&_t=#{timestamp}"
      WebMock.should have_requested(:get, expected_api_hit)
    end
    it "should raise an error when no identity is provided" do
      timestamp = Time.now.to_i
      lambda {
        KM::Resque::RecordJob.perform(nil, "eventName", { :foo => 'bar', :baz => 'bay'}, timestamp)
        }.should raise_error(KM::Resque::Error)
    end
  end
end
