class AdminController < ApplicationController
  def index
    CurrencyChannel.broadcast_to(
      'broadcast',
      rand(50..100)
    )
  end
end
