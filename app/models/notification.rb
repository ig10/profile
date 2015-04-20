class Notification < ActiveRecord::Base
  attr_accessible :source, :message, :ip
  after_create :notify

  def notify
    Notifier.new(self)
  end
end
