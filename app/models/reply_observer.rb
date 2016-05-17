class ReplyObserver < ActiveRecord::Observer
  def after_commit(reply)
    UserMailer.ticket_status(reply.ticket)#.deliver
  end
end
