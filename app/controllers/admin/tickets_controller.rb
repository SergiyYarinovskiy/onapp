class Admin::TicketsController < ApplicationController
  before_action :authenticate_admin_user!
  respond_to :html, :json

  def index
    @tickets = Ticket.all
    respond_with(@tickets)
  end

  def search
    @tickets = Ticket.search(params[:query], load: true)
    respond_with(@tickets)
  end

  def filter
    ids = Status.filter_ids(params[:status])
    @tickets = Ticket.find_by_statuses(ids)
    respond_with(@tickets)
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @reply = Reply.new
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      flash.notice = I18n.t 'strings.ticket_updated'
      redirect_to ticket_path(@ticket)
    else
      flash.alert = @ticket.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:status_id, :admin_user_id)
  end
end
