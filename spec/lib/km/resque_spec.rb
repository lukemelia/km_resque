$:.push File.expand_path('../lib', __FILE__)
require 'km/resque'
require 'resque_spec'

describe "KM::Resque" do
  before(:each) do
    ResqueSpec.reset!
    Time.stub!(:now => Time.now)
    @timestamp = Time.now.to_i
  end
  describe "configuring" do
    it "should capture the API key" do
      KM::Resque.configure do |config|
        config.key = "foo"
      end
      KM::Resque.configuration.key.should == "foo"
    end
  end
  describe "alias" do
    it "should queue an AliasJob" do
      KM::Resque.alias("identifier1", "identifier2")
      KM::Resque::AliasJob.should have_queued("identifier1",
                                              "identifier2",
                                              @timestamp
                                              ).in(:km)
    end
  end
  describe "set" do
    it "should queue an SetJob" do
      KM::Resque.set("identifier", {:some_prop => 'some_val'})
      KM::Resque::SetJob.should have_queued("identifier",
                                            {:some_prop => 'some_val'},
                                            @timestamp
                                            ).in(:km)
    end
  end
  describe "record" do
    it "should queue an RecordJob" do
      KM::Resque.record("identifier", "myEventName", {:some_prop => 'some_val'})
      KM::Resque::RecordJob.should have_queued("identifier",
                                               "myEventName",
                                               {:some_prop => 'some_val'},
                                               @timestamp
                                               ).in(:km)
    end
  end
end
