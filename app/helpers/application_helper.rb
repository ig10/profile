module ApplicationHelper
  def mail_me
    mail_to(@mail, '', {class: 'mail'})
  end
end
