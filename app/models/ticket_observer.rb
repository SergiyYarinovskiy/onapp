class TicketObserver < ActiveRecord::Observer
  def after_commit(ticket)
    UserMailer.ticket_status(ticket)#.deliver
  end
end
