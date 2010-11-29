P4::Application.routes.draw do
  resources :entries do
	resources :comments
  end
  
  resources :tasks
  resources :systems
  resources :components



  devise_for :users , :path => 'user_account'#, :controllers => { :registrations => "users/registrations" }

  resources :users do
	resources :entries, :controller => "accounts"
  end
  
  devise_for :admins, :path => 'admin_account'
  
  resources :admins do
	resources :entries
  end
  
  match "/admin" => "home#admin"
  match "user" => "accounts#index"
  match "/admin/form/edit" => "form#edit"
  match "/users/:user_id/entries/new" => "accounts#new"
  match "/users/:user_id/entries/:id/edit" => "accounts#edit"
  match "/entries/new" => "entries#new"
  match "search" => "entries#search"
  match "intro" => "entries#intro"

  match "/entries.rss" => "entries#rss"
  
  namespace :user do
	root :to => "accounts#index", :controller => "accounts"
  end
  
  namespace :admin do
	root :to => "home#admin", :controller => "home"
  end
  
  root :to => "home#welcome"

end
