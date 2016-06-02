require "oystercard"
require "journey"
require "journey_log"
require "station"

describe "Feature test" do

	it "Charged correctly for complete Journey" do
		oyster = Oystercard.new
		waterloo = Station.new("Waterloo", 1)
		aldgate = Station.new("Aldgate", 1)
		oyster.top_up(50)
		oyster.touch_in(waterloo)
		expect{oyster.touch_out(aldgate)}.to change{oyster.balance}.by (-Oystercard::MIN_FARE)
	end

	it "Charges penalty for no entry journey" do 
		oyster = Oystercard.new
		waterloo = Station.new("Waterloo", 1)
		aldgate = Station.new("Aldgate", 1)
		oyster.top_up(50)
		expect{oyster.touch_out(aldgate)}.to change{oyster.balance}.by (-Journey::PENALTY_FARE)
	end

	it "Charges penalty for no exit journey" do 
		oyster = Oystercard.new
		waterloo = Station.new("Waterloo", 1)
		aldgate = Station.new("Aldgate", 1)
		oyster.top_up(50)
		oyster.touch_in(waterloo)
		expect{oyster.touch_in(aldgate)}.to change{oyster.balance}.by (-Journey::PENALTY_FARE)
	end

end
