class Oystercard

attr_reader :balance, :in_journey, :entry_station

LIMIT = 90
BALANCE = 0
MINIMUM_FARE = 1

  def initialize(balance = BALANCE)
    @balance = balance
  end

  def top_up(amount)
    fail "Limit £#{LIMIT} exceeded" if full?(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    fail 'not enough credit' if empty?
    @entry_station = entry_station
  end

  def touch_out
    @entry_station = nil
    deduct(MINIMUM_FARE)
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
