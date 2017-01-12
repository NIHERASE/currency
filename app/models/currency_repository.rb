class CurrencyRepository
  KEY = 'currency_value'

  class << self
    def save(value)
      Redis.current.set(KEY, value)
    end

    def get
      Redis.current.get(KEY)
    end
  end
end
