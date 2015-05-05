Profile::Application.routes.draw do
  root to: 'home#index'

  match '/v2' => 'home#redesign'

  scope controller: 'scrapper' do
    scope 'iec' do
      match '/', action: 'iec'
      match '/request', action: 'iec_request', as: :request_wh
    end
  end

end
