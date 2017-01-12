class MonitorController < ApplicationController
  def index
    @ruble_rate = CurrencyRepository.get || '__'
  end
end
