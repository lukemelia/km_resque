$:.push File.expand_path('../../lib', __FILE__)
require 'webmock/rspec'
require 'km/resque/alias_job'

describe "KM::Resque::AliasJob" do
  before(:each) do
    stub_request(:any, %r{http://trk.kissmetrics.com.*})
    KM::Resque.configure do |config|
      config.key = "abc123"
    end
  end
  describe "perform" do
    it "should hit the KM API" do
      timestamp = Time.now.to_i
      KM::Resque::AliasJob.perform("identifier1", "identifier2", timestamp)
      expected_api_hit = "http://trk.kissmetrics.com/a?_d=1&_k=abc123&_n=identifier2&_p=identifier1&_t=#{timestamp}"
      WebMock.should have_requested(:get, expected_api_hit)
    end
  end
end
