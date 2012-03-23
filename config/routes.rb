SuggestionBoxApp::Application.routes.draw do

  resources :users
  get '/sessions/new' => 'sessions#new', :as => :new_session
  post '/sessions' => 'sessions#create'
  get '/sessions' => 'sessions#destroy', :as => :signout

  root :to => 'suggestion_boxes#index'

  resources :suggestion_boxes do
    resources :suggestions do
      resources :votes
    end
  end

  get '/suggestion_box/:id/close' => 'suggestion_boxes#close', :as => :close_suggestion_box
  get '/suggestion_box/:id/open' => 'suggestion_boxes#open', :as => :open_suggestion_box

end
