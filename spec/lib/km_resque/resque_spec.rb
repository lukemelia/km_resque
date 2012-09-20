$:.push File.expand_path('../lib', __FILE__)
require 'km_resque'
require 'resque_spec'

describe "KmResque" do
  before(:each) do
    ResqueSpec.reset!
    Time.stub!(:now => Time.now)
    @timestamp = Time.now.to_i
  end
  describe "configuring" do
    it "should capture the API key" do
      KmResque.configure do |config|
        config.key = "foo"
      end
      KmResque.configuration.key.should == "foo"
    end
  end
  describe "alias" do
    it "should queue an AliasJob" do
      KmResque.alias("identifier1", "identifier2")
      KmResque::AliasJob.should have_queued("identifier1",
                                              "identifier2",
                                              @timestamp
                                              ).in(:km)
    end
  end
  describe "set" do
    it "should queue an SetJob" do
      KmResque.set("identifier", {:some_prop => 'some_val'})
      KmResque::SetJob.should have_queued("identifier",
                                            {:some_prop => 'some_val'},
                                            @timestamp
                                            ).in(:km)
    end
  end
  describe "record" do
    it "should queue an RecordJob" do
      KmResque.record("identifier", "myEventName", {:some_prop => 'some_val'})
      KmResque::RecordJob.should have_queued("identifier",
                                               "myEventName",
                                               {:some_prop => 'some_val'},
                                               @timestamp
                                               ).in(:km)
    end
  end
end
