class AdminController < ApplicationController
  def index
    @override = OverrideRepository.get
    @override ||= Override.new(active_until: DateTime.now + 5.minutes)
  end

  def create
    @override = Override.new(override_params)
    if @override.valid?
      OverrideService.set(@override)
      flash[:notice] = 'Форсирование успешно установлено'
      redirect_to admin_path
    else
      flash.now[:error] = @override.errors.full_messages.join(', ')
      render :index
    end
  end

  private

  def override_params
    params.require('override').permit('value', 'active_until')
  end
end
