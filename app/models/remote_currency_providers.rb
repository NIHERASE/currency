module RemoteCurrencyProviders
  PROVIDERS = [Rbc, Dummy]

  def self.get_currency
    PROVIDERS.each do |provider|
      value = provider.get_currency
      break value if value
    end
  end
end
