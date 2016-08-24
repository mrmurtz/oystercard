require_relative 'journey'

class Oystercard

attr_reader :balance, :in_journey, :journeys, :current_journey

LIMIT = 90
BALANCE = 0

  def initialize(balance = BALANCE)
    @balance = balance
    @in_journey = false
    @journeys = []
    @current_journey = nil
  end

  def top_up(amount)
    fail "Limit £#{LIMIT} exceeded" if full?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    fail 'not enough credit' if empty?
    # if current journey exists charge PENALTY_FARE
    # store that journey in journey history
    # and then clear current journey

    @current_journey = Journey.new
    current_journey.start(entry_station)
    journeys << {entry_station: current_journey.entry_station, exit_station: nil}
    # instantiate journey instance
    # start the journey and pass the station in
    # store current journey (for referencing later)
  end

  def touch_out(exit_station)
    # create new journey (if one doesn;t exist)
    # finish that journey
    # calc PENALTY_FARE
    # store it in journey history
    # clear that current journey

    current_journey.finish(exit_station)
    deduct(current_journey.fare)
    journeys[-1][:exit_station] = exit_station
    @current_journey = nil
    # grab current journey
    # call finish on it
    # calc fare
    # store in journey history
    # clear current journey
  end

  private

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
