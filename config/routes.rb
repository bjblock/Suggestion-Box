SuggestionBoxApp::Application.routes.draw do

  resources :users
  get '/sessions/new' => 'sessions#new', :as => :new_session
  post '/sessions' => 'sessions#create'
  get '/sessions' => 'sessions#destroy', :as => :signout

  root :to => 'suggestion_boxes#index'

  resources :suggestion_boxes do
    post '/invitation_keys' => 'invitation_keys#create'
    get '/invitation_keys/new' => 'invitation_keys#new', :as => :new_invitation_key
    get '/invitation_keys/reset' => 'invitation_keys#reset', :as => :reset_invitation_keys
    resources :suggestions do
      resources :votes
    end
  end
  
  get '/suggestion_boxes/:id/check' => 'suggestion_boxes#check', :as => :check_key_suggestion_box
  get '/suggestion_boxes/:id/close' => 'suggestion_boxes#close', :as => :close_suggestion_box
  get '/suggestion_boxes/:id/open' => 'suggestion_boxes#open', :as => :open_suggestion_box

end
