Profile::Application.routes.draw do
  root to: 'home#index'

  scope controller: 'scrapper' do
    match 'iec', action: 'iec'
  end
end
