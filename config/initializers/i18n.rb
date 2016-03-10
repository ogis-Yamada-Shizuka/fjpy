module I18n
  class << self
    alias_method :safe_localize, :localize

    def localize(object, options = {})
      object.present? ? safe_localize(object, options) : ''
    end
  end
end
