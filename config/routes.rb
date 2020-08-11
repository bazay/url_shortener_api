Rails.application.routes.draw do
  mount UrlShortenerApi::ApplicationApi => '/'
end
