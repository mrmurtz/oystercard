class JourneyLog

  attr_reader :journey, :journeys

  def initialize
    @journey = nil
    @journeys = []
  end

  def start(entry_station)
    current_journey.start(entry_station)
    journeys << {entry_station: entry_station, exit_station: nil}
  end

  def finish(exit_station)
    current_journey.finish(exit_station)
    journeys[-1][:exit_station] = exit_station
  end

  def current_journey
    journey != nil ? journey : @journey = Journey.new
  end

end
