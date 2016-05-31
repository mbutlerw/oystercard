require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_reader :balance, :journeys

  def initialize
    @lower_limit= MINIMUM_FARE
    @upper_limit= MAXIMUM_BALANCE
    @balance= 0
    @journeys= []
  end

  def top_up(value)
    fail "top up exceeds balance limit, cannot top up" if maximum_balance_exceeded?(balance,value)
    @balance += value
  end

  def in_journey?
    @journey.complete?
  end

  def touch_in(station)
    fail "Insufficient balance" if !minimum_balance?(balance)
    touch_out(nil) if @journey
    create_journey(journey = Journey.new(station))
  end

  def touch_out(station)
    @journey ? deduct(correct_fare(station)) : deduct(PENALTY_FARE)
    store_journey
    @journey = nil
  end

  private
  attr_reader :upper_limit, :lower_limit

  def deduct(value)
    @balance -= value
  end

  def store_journey
    journeys << @journey
  end

  def minimum_balance?(balance)
    balance > lower_limit
  end

  def maximum_balance_exceeded?(balance,value)
    balance+value > upper_limit
  end

  def create_journey(journey)
    @journey = journey
  end

  def correct_fare(station)
  @journey.finish(station)[:fare]
  end

end
