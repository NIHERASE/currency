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

      value = JSON.parse(Typhoeus.get('http://www.rbc.ru/ajax/indicators').body)['currency'].find { |h| h['name'] == 'USD' && h['subname'] == 'Бирж.' }['value1']
      CurrencyChannel.broadcast(value)
      CurrencyRepository.save(value)
    end
  end
end
