class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(amount)
    max_reached = @balance + amount > MAX_LIMIT
    error_message = "Error: card limit is #{MAX_LIMIT}"
    max_reached ? (raise error_message) : @balance += amount
  end

  def touch_in(station)
    fail("Error, insufficient balance") if @balance < MIN_LIMIT
    @entry_station = station
  end

  def touch_out(exit_station)
    @balance -= 1
    @exit_station = exit_station
    @journey_history << {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
  end


  def in_journey?
    !@entry_station.nil?
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
