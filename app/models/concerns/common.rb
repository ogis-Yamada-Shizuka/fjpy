module Common
  def dump
    @@h = {}
    self.attributes.each{ |key, val|
      @@h.store(self.class.to_s+"."+key,val)
    }
    STDOUT.puts(Rails.application.class.parent_name+":"+@@h.to_json)
  end

  def currentDate
    Date.today.in_time_zone.to_s[0..9]
  end

  def currentMonth
    Date.today.in_time_zone.to_s[0..6]
  end

end
