class UserMailer < ActionMailer::Base
  default from: 'issue_tracker@example.com'

  def ticket_status(ticket)
    mail(
      to: ticket.email,
      subject: I18n.t('strings.email_subject'),
      body: I18n.t(
        'strings.email_body',
        ticket_name: ticket.name,
        ticket_url: ticket_url(ticket)
      )
    )
  end
end
