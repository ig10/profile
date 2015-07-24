Profile::Application.routes.draw do
  root to: 'home#index'

  get '/v2' => 'home#redesign'

  scope controller: 'scrapper' do
    scope 'iec' do
      get '/', action: 'iec'
      get '/request', action: 'iec_request', as: :request_wh
    end
  end

end
