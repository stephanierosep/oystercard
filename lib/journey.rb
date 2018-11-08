class Journey

attr_reader :entry_station, :exit_station

 MIN_FARE = 1
 PENALTY_FARE = 6

 def initialize(entry_station)
   @entry_station = entry_station
   @exit_station = nil
 end

  def finish_journey(exit_station)
    @exit_station = exit_station
  end

  def fare
    if self.entry_station.nil? || self.exit_station.nil?
      return PENALTY_FARE
    else
      return MIN_FARE
    end
  end

  def complete?
    !self.entry_station.nil? && !self.exit_station.nil?
  end

end
