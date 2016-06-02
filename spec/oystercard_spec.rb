require 'oystercard'

describe Oystercard do

	subject(:oystercard) { described_class.new(journey_log) }

	let(:station) { double :station }
	let(:exit_station) { double :exit_station }
	let(:journey) {double :journey, start: station, finish: exit_station}
	let(:journey_log) {double :journey_log, start: station, finish: nil}

	describe '#balance' do

		it 'should eq zero by default' do
			expect(oystercard.balance).to eq 0
		end

	end

	describe '#topup' do

		it 'should respond to #topup with 1 argument' do
			expect(oystercard).to respond_to(:top_up).with(1).argument
		end

		it 'topup(value) should increase #balance by value' do
			oystercard.top_up(20)
			expect(oystercard.balance).to eq(20)
		end

		it 'topup should raise error if balance would be over limit' do
			max_balance = Oystercard::MAX_BALANCE
			expect{oystercard.top_up(100)}.to raise_error "Balance exceeded limit of #{max_balance}"
		end

	end


	describe '#touch_in' do

		it { is_expected.to respond_to(:touch_in).with(1).argument }

		it 'fails if balance is below MIN_FARE' do
			expect{oystercard.touch_in(station)}.to raise_error "insufficient balance"
		end

		# it 'charges penalty fare when incomplete journey (no finish)' do
		# 	allow(journey_log).to receive(:journey){journey}
		# 	allow(journey).to receive(:calculate_fair){6}
		# 	oystercard.topup(10)
		# 	expect(oystercard.journey_log).to receive(:start)
		# 	oystercard.touch_in(station)
		# end
	end


	describe '#touch_out' do

		it { is_expected.to respond_to(:touch_out).with(1).argument }

		# it 'charges min fair for complete journey' do
		# 	oystercard.topup(10)
		# 	oystercard.touch_in(station)
		# 	expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by (-Oystercard::MIN_FARE)
		# end

		# it 'charges PENALTY_FARE for incomplete journey (no entry)' do
		# 	oystercard.top_up(10)
		# 	expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by (-Journey::PENALTY_FARE)
		# end

	end

end
