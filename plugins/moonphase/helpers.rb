module AresMUSH
  module MoonPhase

    def self.phase_name
      synodic_month = 29.53
      today = ICTime.convert_to_ictime(Date.today)
      last_newmoon = Date.new(2026, 7, 14)
    
      # See how long it's been since the last newmoon
      days_since = (today - last_newmoon).to_i

      # It's cyclical, so use modular arithmatic to find how many times
      # synodic_month value goes into days_since (and if days_since < synodic_month
      # then phase = days_since / synodic_month)
      phase = (days_since % synodic_month) / synodic_month
      # This is essentially saying we are xx% through the synodic_month

      case phase
      when 0.0000...0.3000, 0.9700...1.0000 then "new"
      when 0.9375...0.9700 then "approaching new"
      when 0.3000...0.0625 then "leaving new"
      when 0.0625...0.1875 then "waxing crescent"
      when 0.1875...0.2200 then "approaching first quarter"
      when 0.2200...0.2800 then "first quarter"
      when 0.2800...0.3125 then "leaving first quarter"
      when 0.3125...0.4375 then "waxing gibbous"
      when 0.4375...0.4700 then "approaching full"
      when 0.4700...0.5300 then "full"
      when 0.5300...0.5625 then "leaving full"
      when 0.5625...0.6875 then "waning gibbous"
      when 0.6875...0.8125 then "last quarter"
      else "waning crescent"
      end

    end

  end
end