require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :fare

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(station = nil)
    @entry_station = station
  end

  def finish(station = nil)
    @exit_station = station
    calculate_fare
    self
  end

  def complete?
    entry_station && exit_station
  end

  def calculate_fare
    @fare = complete? ? Oystercard::MIN_FARE : PENALTY_FARE
  end

end
