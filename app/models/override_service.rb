class OverrideService
  class << self
    def set(override)
      if OverrideRepository.save(override)
        value = override.value
        CurrencyRepository.save(value)
        CurrencyChannel.broadcast(value)
      end
    end
  end
end
