Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do
      devise_scope :user do
        post :sessions, :to => 'sessions#create'
        delete :session, :to => 'sessions#logout'
        post :registrations, :to => 'registrations#create'
        delete :registration, :to => 'registration#destroy'
      end
    end
  end
end
