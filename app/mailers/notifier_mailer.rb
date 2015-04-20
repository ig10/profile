class NotifierMailer < ApplicationMailer

  def scrapper_error(notification)
    @notification = notification
    @origin_address = origin_address
    @recipient = default_recipient
    mail(
      from: format_mail(@origin_address),
      to: format_mail(@recipient),
      subject: '[ig10.org] Scrapper Error Notification'
      )
  end

  private

    def format_mail(email_address)
      "#{email_address[:name]} <#{email_address[:mail]}>"
    end
end
