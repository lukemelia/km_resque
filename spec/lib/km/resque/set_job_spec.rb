$:.push File.expand_path('../../lib', __FILE__)
require 'webmock/rspec'
require 'km/resque/set_job'

describe "KM::Resque::SetJob" do
  before(:each) do
    stub_request(:any, %r{http://trk.kissmetrics.com.*})
    KM::Resque.configure do |config|
      config.key = "abc123"
    end
  end
  describe "perform" do
    it "should hit the KM API" do
      timestamp = Time.now.to_i
      KM::Resque::SetJob.perform("identifier", { :foo => 'bar', :baz => 'bay'}, timestamp)
      expected_api_hit = "http://trk.kissmetrics.com/s?_d=1&_k=abc123&_p=identifier&_t=#{timestamp}&baz=bay&foo=bar"
      WebMock.should have_requested(:get, expected_api_hit)
    end
  end
end
