P4::Application.routes.draw do
  resources :entries do
	resources :comments
	resources :favorites
  end
  
  resources :tasks
  resources :systems
  resources :components



  devise_for :users do
	resources :favorites
  end
  #, :path => ''#, :controllers => { :registrations => "users/registrations" }
  #devise_for :users, :as => "", :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" } 

	#match "login" => "devise/sessions#new", :as => :new_user_session 
	#match "logout" => "devise/sessions#destroy", :as => :destroy_user_session
	#match "register" => "devise/registrations#new", :as => :new_user_registration

  #resources :users do
	#resources :entries, :controller => "accounts"
	#resources :favorites
  #end
  

  #resources :accounts do
	#resources :entries
	#resources :favorites
  #end
  
  devise_for :admins
  
  
  match "/admin" => "home#admin"
  match "/user/" => "home#user"
  match "/admin/form/edit" => "form#edit"
  #match "/users/:user_id/entries/new" => "accounts#new"
  #match "/users/:user_id/entries/:id/edit" => "accounts#edit"
  match "/entries/new" => "entries#new"
  match "/entries/:id/edit" => "entries#edit"
  match "search" => "entries#search"
  match "intro" => "entries#intro"
  #match "/favorites/new" => "favorites#new"
  #match "/entries/:id" => "entries#show"

  match "/entries.rss" => "entries#rss"
  
  namespace :user do
	root :to => "home#user",  :controller => "home"
  end
  
  namespace :admin do
	root :to => "home#admin", :controller => "home"
  end
  
  root :to => "home#welcome"

end
