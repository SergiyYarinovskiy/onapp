class TicketsController < ApplicationController
  respond_to :html, :json

  def new
    @ticket = Ticket.new
  end

  def show
    @ticket = Ticket.find(params[:id])
    respond_with(@ticket)
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      flash.notice = I18n.t 'strings.ticket_created'
      redirect_to ticket_path(@ticket)
    else
      flash.alert = @ticket.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(
      :name, :email, :subject, :description, :department
    )
  end
end
