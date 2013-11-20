WorldSource::Application.routes.draw do
  get "tweets/home"

  root 'tweets#home'
end
