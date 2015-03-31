class Notification < ActiveRecord::Base
  attr_accessible :source, :message, :ip
  after_create :notify

  def notify
    Notifier.deliver_scrapping_error(self)
  end

end