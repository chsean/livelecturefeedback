Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/test')

  get '/test', to: 'tests#new'
  get '/teacher', to: 'teachers#show' , defaults: { format: :js }


end
