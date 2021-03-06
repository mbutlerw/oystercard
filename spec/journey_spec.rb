require 'journey'
require 'oystercard'


describe Journey do
  let (:station) {double :station, zone: 1}
  let(:other_station) { double :other_station, zone: 1 }

  context "given an entry station" do

    subject(:journey) {described_class.new}

    before {journey.start(station)}

    it "has an entry station" do
      expect(journey.entry_station).to eq station
    end

    it 'journey is complete' do
      expect(journey).not_to be_complete
    end

    it 'fare should return minimum fare' do
      expect(journey.calculate_fare).to eq (Journey::PENALTY_FARE)
    end

    it 'returns itself when finish' do
      expect(journey.finish(other_station)).to eq journey
    end
  end

  context "given an exit station" do

    subject(:journey) {described_class.new}

    before{journey.finish(other_station)}

    it 'has an exit station' do
        expect(journey.exit_station).to eq other_station
    end

    it 'journey is complete' do
      expect(journey).not_to be_complete
    end

    it 'fare should return minimum fare' do
      expect(journey.fare).to eq (Journey::PENALTY_FARE)
    end
  end

  context "given both an entry and exit station" do

    subject(:journey) {described_class.new}

    before {journey.start(station)}

    before {journey.finish(other_station)}

    it 'journey is complete' do
      expect(journey).to be_complete
    end

    it 'fare should return minimum fare' do
      expect(journey.fare).to eq (Oystercard::MIN_FARE)
    end

  end
end
