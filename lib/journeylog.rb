class JourneyLog

attr_reader :logbook

  def initialize
    @logbook = []

  end

  def start(station)
    @logbook << Journey.new(station)
  end
  end
