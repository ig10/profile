class Notifier

  def initialize(type='mail', notification)
    @notification = notification
    method = (type == 'mail' ? :deliver_scrapper_error : :send_live_notification)
    send(method)
  end

  private

    def deliver_scrapper_error
      NotifierMailer.scrapper_error(@notification).deliver
    end

    def send_live_notification; end

end
