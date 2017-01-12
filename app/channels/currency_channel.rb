class CurrencyChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'currency:broadcast'
  end

  def self.broadcast(value)
    broadcast_to('broadcast', value)
  end
end
