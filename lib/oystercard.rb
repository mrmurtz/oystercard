require_relative 'journey'
require_relative 'journey_log'

class Oystercard

attr_reader :balance, :journeylog

LIMIT = 90
BALANCE = 0

  def initialize(balance = BALANCE, journeylog = JourneyLog.new)
    @balance = balance
    @journeylog = journeylog
  end

  def top_up(amount)
    fail "Limit £#{LIMIT} exceeded" if full?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    fail 'not enough credit' if empty?
    journeylog.start(entry_station)
  end

  def touch_out(exit_station)
    journeylog.finish(exit_station)
    deduct(journeylog.current_journey.fare)
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
