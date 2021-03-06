class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station

  def initialize
   @balance = 0
  end

  def top_up(amount)
    fail "Can't add more than £#{MAXIMUM_BALANCE}" if balance + amount >  MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail "You're already touched in!" if in_journey?
    fail "Your balance is less than £1" if below_limit?
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    fail "You're already touched out!" if !in_journey?
    @in_journey = false
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end

  private
  def below_limit?
    balance < MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

end
