require_relative 'journey'

class Oystercard

attr_reader :balance, :in_journey, :journeys, :current_journey, :journeylog

LIMIT = 90
BALANCE = 0

  def initialize(balance = BALANCE, journeylog = JourneyLog.new)
    @balance = balance
    @in_journey = false
    @journeys = []
    @current_journey = nil
    @journeylog = journeylog
  end

  def top_up(amount)
    fail "Limit £#{LIMIT} exceeded" if full?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    fail 'not enough credit' if empty?
    journeylog.start(entry_station)
    # if current_journey != nil
    #   pen_for_not_touching_out
    # end
    # new_journey
    # current_journey.start(entry_station)
    journeys << {entry_station: journeylog.journey.entry_station, exit_station: nil}
  end

  def touch_out(exit_station)
    if current_journey == nil
      new_journey
      journeys << {entry_station: nil, exit_station: exit_station}
    end
    current_journey.finish(exit_station)
    deduct(current_journey.fare) #
    journeys[-1][:exit_station] = exit_station
    @current_journey = nil #
  end

  private

  def pen_for_not_touching_out
    deduct(current_journey.fare)
    journeys << {entry_station: current_journey.entry_station, exit_station: nil}
    @current_journey = nil
  end

  def new_journey
    @current_journey = Journey.new
  end

  def full?(amount)
    @balance + amount > LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

  def empty?
    @balance < Journey::MINIMUM_FARE
  end

end
