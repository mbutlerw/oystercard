require_relative 'journey'

class JourneyLog

  attr_reader :journeys, :journey
  
  def initialize
    @journeys = []
    @journey = nil
  end

  def create_journey(journey = Journey.new)
      @journey = journey
  end

  def start(station)
    open_journey_check
    create_journey
    @journey.start(station)
  end

  def finish(station)
    create_journey if @journey == nil
    @journeys << @journey.finish(station)
    @journey = nil
  end

  def open_journey_check
      if @journey
         @journeys << @journey.finish
      end
  end

  def last_fare 
    @journeys.last.fare
  end

end
