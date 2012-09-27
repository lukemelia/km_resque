$:.push File.expand_path('../lib', __FILE__)
require 'km_resque'
require 'resque_spec'

describe "KmResque" do
  before(:each) do
    ResqueSpec.reset!
    Time.stub!(:now => Time.now)
    @prior_timestamp = Time.now.to_i-(60 * 60 * 24)
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
    it "should queue an AliasJob with current time" do
      KmResque.alias("identifier1", "identifier2")
      KmResque::AliasJob.should have_queued("identifier1",
                                              "identifier2",
                                              @timestamp
                                              ).in(:km)
    end
  end
  describe "set" do
    it "should queue a SetJob with current time" do
      KmResque.set("identifier", {:some_prop => 'some_val'})
      KmResque::SetJob.should have_queued("identifier",
                                            {:some_prop => 'some_val'},
                                            @timestamp
                                            ).in(:km)
    end
  end
  describe "record" do
    it "should queue a RecordJob with current time" do
      KmResque.record("identifier", "myEventName", {:some_prop => 'some_val'})
      KmResque::RecordJob.should have_queued("identifier",
                                               "myEventName",
                                               {:some_prop => 'some_val'},
                                               @timestamp
                                               ).in(:km)
    end
  end
  describe "alias" do
    it "should queue an AliasJob with arbitrary timestamp" do
      KmResque.alias("identifier1", "identifier2", @prior_timestamp)
      KmResque::AliasJob.should have_queued("identifier1",
                                              "identifier2",
                                              @prior_timestamp
                                              ).in(:km)
    end
  end
  describe "set" do
    it "should queue a SetJob with arbitrary timestamp" do
      KmResque.set("identifier", {:some_prop => 'some_val'}, @prior_timestamp)
      KmResque::SetJob.should have_queued("identifier",
                                            {:some_prop => 'some_val'},
                                            @prior_timestamp
                                            ).in(:km)
    end
  end
  describe "record" do
    it "should queue a RecordJob with arbitrary timestamp" do
      KmResque.record("identifier", "myEventName", {:some_prop => 'some_val'}, @prior_timestamp)
      KmResque::RecordJob.should have_queued("identifier",
                                               "myEventName",
                                               {:some_prop => 'some_val'},
                                               @prior_timestamp
                                               ).in(:km)
    end
  end
end
