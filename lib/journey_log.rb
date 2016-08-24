class JourneyLog

  attr_reader :journey

  def initialize
    @journey = nil
  end

  def start(entry_station)
    current_journey
    journey.start(entry_station)
  end

  private

  def current_journey
    journey != nil ? journey : @journey = Journey.new
  end

end
