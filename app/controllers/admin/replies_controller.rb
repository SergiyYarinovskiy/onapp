class Admin::RepliesController < ApplicationController
  before_action :authenticate_admin_user!

  def create
    @reply = Reply.new(reply_params)
    if @reply.save
      flash.notice = I18n.t 'strings.reply_created'
    else
      flash.alert = @reply.errors.full_messages.join(", ")
    end
    redirect_to ticket_path(@reply.ticket)
  end

  private

  def reply_params
    params.require(:reply).permit(:body, :ticket_id, :admin_user_id)
  end
end
