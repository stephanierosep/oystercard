require './lib/journey'

class Oystercard
  attr_reader :balance, :journey_history

  MAX_LIMIT = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    max_reached = @balance + amount > MAX_LIMIT
    error_message = "Error: card limit is #{MAX_LIMIT}"
    max_reached ? (raise error_message) : @balance += amount
  end

  def touch_in(station)
    fail("Error, insufficient balance") if @balance < MIN_BALANCE
    @journey_history << Journey.new(station)
  end

  def touch_out(exit_station)
    @journey_history.last.finish_journey(exit_station)
    deduct(@journey_history.last.fare)
  end

  def in_journey?
    !@journey_history.last.entry_station.nil? && @journey_history.last.exit_station.nil?
  end



private

  def deduct(amount)
    if @balance - amount < 0
      raise("balance cannot be negative")
    else
      @balance -= amount
    end
  end


end
