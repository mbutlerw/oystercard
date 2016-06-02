
require_relative 'journey_log'

class Oystercard

	attr_reader :balance, :journey_log

	MAX_BALANCE = 90
  MIN_FARE = 1

	def initialize(journey_log = JourneyLog.new)
		@balance = 0
		@journey_log = journey_log
	end

	def top_up(value)
    fail "Balance exceeded limit of #{MAX_BALANCE}" if (balance + value) > MAX_BALANCE
		@balance += value
	end

  def touch_in(station)
    fail 'insufficient balance' if balance < MIN_FARE
    no_touch_out_penalty
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
		deduct(@journey_log.last_fare)
  end

	  private

	  def deduct(value)
	    @balance -= value
	  end

	  def no_touch_out_penalty
	  	deduct @journey_log.journey.calculate_fare if @journey_log.journey
	  end

end
