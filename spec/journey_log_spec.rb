require 'journey_log'

describe JourneyLog do

  subject(:journey_log) { described_class.new }
  let(:station) { double :station, zone: 1 }
  let(:journey) { double :journey, start: station, finish: self }
  let(:other_station) { double :other_station, zone: 1 }

  describe "#start" do 
    it "starts a new journey" do 
    journey_log.create_journey(journey)
    expect(journey_log.journey).to_not eq nil
    end
  end

  describe "#finish" do
    it "finishes a new journey" do
    journey_log.create_journey(journey)
    expect(journey).to receive(:finish)
    journey_log.start(station)
    journey_log.finish(other_station)
    end
  end

  describe "#journeys" do 

    it "has an empty journey log by default" do
      expect(journey_log.journeys).to be_empty
    end
    
    it "returns journey history" do
      journey_log.create_journey
      journey_log.start(station)
      journey_log.finish(other_station)
      expect(journey_log.journeys).to_not be_empty
    end
  end

end
