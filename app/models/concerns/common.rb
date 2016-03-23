module Common
  def dump
    @h = {}
    attributes.each do |key, val|
      @h.store(self.class.to_s + '.' + key, val)
    end
    STDOUT.puts(Rails.application.class.parent_name + ':' + @h.to_json)
  end

  def current_date
    Time.zone.today.in_time_zone.to_s[0..9]
  end

  def current_month
    Time.zone.today.in_time_zone.to_s[0..6]
  end
end
