class HomeController < ActionController::Base
  layout 'application'
  protect_from_forgery

  def index
    @name = "Ignacio Diez"
    @social = {
      'facebook' => 'https://www.facebook.com/ignacio10',
      'twitter' => 'https://twitter.com/igdiez',
      'linkedin' => 'https://cl.linkedin.com/pub/ignacio-diez-albornoz/45/589/b1a',
      'github' => 'https://github.com/ig10'
     }
  end

end