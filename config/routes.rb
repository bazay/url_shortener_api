Rails.application.routes.draw do
  get '/s/:slug', to: 'redirects#show', as: :slug

  mount ApplicationApi => '/'
end
