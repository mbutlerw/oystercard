require 'journeylog'

describe JourneyLog do

subject(:journeylog) {described_class.new}
let(:station) {double :station}


  describe "upon initialization" do
   it "creates an empty array variable to store journeys" do
    expect(journeylog.logbook).to eq []
   end
 end

  describe '#start' do
    it "should create a new journey" do
      journeylog.start(station)
      expect(journeylog.logbook.last).to_not eq nil
    end
  end
end
