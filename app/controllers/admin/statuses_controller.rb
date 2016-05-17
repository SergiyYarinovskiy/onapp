class Admin::StatusesController < ApplicationController
  before_action :authenticate_admin_user!

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    if @status.save
      flash.notice = I18n.t 'strings.status_created'
      redirect_to tickets_path
    else
      flash.alert = @status.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def status_params
    params.require(:status).permit(:name)
  end
end
