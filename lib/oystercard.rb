class Oystercard

attr_reader :balance, :in_journey, :entry_station, :journeys, :exit_station

LIMIT = 90
BALANCE = 0
MINIMUM_FARE = 1

  def initialize(balance = BALANCE)
    @balance = balance
    @in_journey = false
    @journeys = []
  end

  def top_up(amount)
    fail "Limit £#{LIMIT} exceeded" if full?(amount)
    @balance += amount
  end

  def in_journey?
    !!@in_journey
  end

  def touch_in(entry_station)
    fail 'not enough credit' if empty?
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @in_journey = false
    @exit_station = exit_station
    @journeys << {:entry_station => entry_station, :exit_station => exit_station}
  end

  private

  def full?(amount)
    @balance + amount > LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

  def empty?
    @balance < MINIMUM_FARE
  end
end
