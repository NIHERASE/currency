module RemoteCurrencyProviders
  class Dummy
    VALUE = '__'

    def self.get_currency
      VALUE
    end
  end
end
