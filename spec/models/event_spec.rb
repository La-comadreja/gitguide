require 'rails_helper'

describe Event do
  before(:each) do
    @event = FactoryGirl.build(:event)
    expect(@event).to be_valid
  end

  it "requires a category" do
    @event.category = nil
    expect(@event).to be_invalid
  end

  it "requires category to be under 100 characters" do
    @event.category = "A" * 100
    expect(@event).to be_valid
    @event.category << "A"
    expect(@event).to be_invalid
  end

  it "requires a datetime" do
    @event.datetime = nil
    expect(@event).to be_invalid
  end

  it "requires a name" do
    @event.name = nil
    expect(@event).to be_invalid
  end

  it "requires event name to be under 100 characters" do
    @event.name = "A" * 100
    expect(@event).to be_valid
    @event.name << "A"
    expect(@event).to be_invalid
  end

  it "allows venue to be nil" do
    @event.venue = nil
    expect(@event).to be_valid
  end

  it "requires non-nil venue name to be under 100 characters" do
    @event.venue = "A" * 100
    expect(@event).to be_valid
    @event.venue << "A"
    expect(@event).to be_invalid
  end

  it "requires an address" do
    @event.address = nil
    expect(@event).to be_invalid
  end

  it "requires address to be under 200 characters" do
    @event.address = "A" * 200
    expect(@event).to be_valid
    @event.address << "A"
    expect(@event).to be_invalid
  end

  it "requires a latitude" do
    @event.latitude = nil
    expect(@event).to be_invalid
  end

  it "requires latitude to be a number" do
    @event.latitude = "A"
    expect(@event).to be_invalid
  end

  it "requires a longitude" do
    @event.longitude = nil
    expect(@event).to be_invalid
  end

  it "requires longitude to be a number" do
    @event.longitude = "A"
    expect(@event).to be_invalid
  end

  it "requires a link" do
    @event.link = nil
    expect(@event).to be_invalid
  end

  it "requires link to be under 1000 characters" do
    @event.link = "A" * 1000
    expect(@event).to be_valid
    @event.link << "A"
    expect(@event).to be_invalid
  end

  it "allows price to be nil" do
    @event.price = nil
    expect(@event).to be_valid
  end

  it "requires non-nil price to be a non-negative number" do
    @event.price = "A"
    expect(@event).to be_invalid
    @event.price = -1
    expect(@event).to be_invalid
    @event.price = 0
    expect(@event).to be_valid
  end

  it "allows description to be nil" do
    @event.description = nil
    expect(@event).to be_valid
  end

  it "requires non-nil description to be under 500 characters" do
    @event.description = "A" * 500
    expect(@event).to be_valid
    @event.description << "A"
    expect(@event).to be_invalid
  end

  context "unique fields" do
    before(:each) do
      @event2 = FactoryGirl.build(:event2)
      @event.save
      expect(@event2).to be_invalid
    end

    it "does not allow event latitude/longitude + name + date/time to be case-insensitive duplicated" do
      @event2.name = @event.name.upcase
      expect(@event2).to be_invalid
    end

    it "allows event name + date/time + longitude duplicated if latitude is different" do
      @event2.latitude = 44
      expect(@event2).to be_valid
    end

    it "allows event name + date/time + latitude duplicated if longitude is different" do
      @event2.longitude = -124.2
      expect(@event2).to be_valid
    end

    it "allows event latitude/longitude + date/time duplicated if name is case-insensitive different" do
      @event2.name = "What is Business Casual?"
      expect(@event2).to be_valid
    end

    it "allows venue address + event name duplicated if event date/time is different" do
      @event2.datetime = "2014-10-03 19:00:00"
      expect(@event2).to be_valid
    end
  end
end