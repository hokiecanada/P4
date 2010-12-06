P4::Application.routes.draw do
  resources :entries, :only => [:index, :show]

  devise_for :users do
	resources :entries do
		resources 	:comments,  :only => [:create, :destroy]
		resources 	:favorites, :only => [:create, :destroy]
	end
  end
  
  devise_for :admins do
	resources :entries,		:as => "admin_entries",
							:path => "admin_entries",
							:controller => "admin_entries",
							:only => [:index, :edit, :show, :update, :destroy]
    resources :tasks, 		:only => [:create, :destroy]
	resources :systems, 	:only => [:create, :destroy]
	resources :components, 	:only => [:create, :destroy]
  end
  
  ## HOME ROUTES
  match "intro" 	=> "home#intro"
  match "admin" 	=> "home#admin"
  match "user" 		=> "home#user"

  ## ENTRY ROUTES
  match "/entries/new" 		=> "entries#new"
  match "/entries/:id/edit" => "entries#edit"
  match "/entries.rss" 		=> "entries#rss"
  
  ## FAVORITE ROUTES
  match "entry_favorites" 	=> "favorites#create"
  
  ## SEARCH ROUTES
  match "search" 			=> "search#basic"
  match "search_tag" 		=> "search#tag"
  match "search_advanced" 	=> "search#advanced"

  ## ADMIN ROUTES
  match "admin_edit_entry" 			=> "admin_entries#edit"
  match "admin_entries/:id/edit"	=> "admin_entires#edit"
  match "admin_comments" 			=> "admin_entries#comments"
  match "admin_edit_form" 			=> "admin_form#edit"
  match "admin_update_status" 		=> "admin_entries#update_status"
  
  
  namespace :user do
	root :to => "home#user",  :controller => "home"
  end
  
  namespace :admin do
	root :to => "home#admin", :controller => "home"
  end
  
  root :to => "home#welcome"

end
