module RemoteCurrencyProviders
  class Rbc
    API_URL = 'http://www.rbc.ru/ajax/indicators'

    class << self
      def get_currency
        get_hash.fetch('currency').find do |h|
          h['name'] == 'USD' && h['subname'] == 'Бирж.'
        end.fetch('value1')
      rescue StandardError => e
        Rails.logger.error("Rbc adapter failed: #{e.message}\n#{e.backtrace}")
        nil
      end

      def get_hash
        JSON.parse(get_data)
      end

      def get_data
        Typhoeus.get(API_URL).body
      end
    end
  end
end
