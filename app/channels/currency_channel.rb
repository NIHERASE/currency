class CurrencyChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.error('YAHOO')
    stream_from 'currency:broadcast'
  end
end
