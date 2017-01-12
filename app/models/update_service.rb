class UpdateService
  class << self
    def run
      scheduler = Rufus::Scheduler.new
      scheduler.interval '5s' do
        update
      end

      scheduler.join
    end

    def update
      return unless OverrideRepository.get.nil?

      value = RemoteCurrencyProviders.get_currency
      CurrencyRepository.save(value)
      CurrencyChannel.broadcast(value)
    end
  end
end
