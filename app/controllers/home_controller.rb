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
     @mail = 'ig.diez10@gmail.com'
  end

  def redesign
    render :redesign, layout: 'design_v2'
  end

end
