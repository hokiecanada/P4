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
  
  devise_for :admins do
	resources :entries, :as => "admin_entries", :path => "admin_entries", :controller => "admin_entries", :only => [:index, :edit, :show, :update, :destroy]
  end
  
  
  match "/admin" => "home#admin"
  match "/user/" => "home#user"
  match "/admin/form/edit" => "form#edit"
  match "update_status" => "admin_entries#update_status"
  #match "/users/:user_id/entries/new" => "accounts#new"
  #match "/users/:user_id/entries/:id/edit" => "accounts#edit"
  match "/entries/new" => "entries#new"
  match "/entries/:id/edit" => "entries#edit"
  #match "/entries/:id/update" => "entries#update"
  match "search" => "entries#search"
  match "intro" => "home#intro"
  #match "/favorites/new" => "favorites#new"
  #match "/entries/:id" => "entries#show"
  match "admin_edit_entry" => "admin_entries#edit"
  #match "admin_update_entry" => "admin_entries#update"
  #match "admin_show_entry" => "admin_entries#show"

  match "/entries.rss" => "entries#rss"
  
  namespace :user do
	root :to => "home#user",  :controller => "home"
  end
  
  namespace :admin do
	root :to => "home#admin", :controller => "home"
  end
  
  root :to => "home#welcome"

end
