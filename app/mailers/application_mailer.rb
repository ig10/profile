class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  def origin_address
    { name: 'ig10.org' , mail: 'ig10.org@gmail.com' }
  end

  def default_recipient
    { name: 'Ignacio Diez' , mail: 'ig.diez10@gmail.com' }
  end

end
