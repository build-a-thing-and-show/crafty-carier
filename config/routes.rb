Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  namespace :api do
    post 'hellome', to: 'hellome#hello'
  end
end
