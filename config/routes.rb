ActionController::Routing::Routes.draw do |map|
  map.resources :projects
  map.resources :project_volunteers, :only => [:create, :delete, :update]
  map.resources :password_resets, :except => [:index, :destroy, :show]

  map.resources :users, :as => :volunteers, :except => :destroy
  map.signup '/signup', :controller => 'users', 
                        :action => 'new'                      
  
  map.resource :user_session, :only => [:new, :create, :destroy]
  
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', 
                        :action => 'destroy', 
                        :conditions => { :method => :delete }
                        
  map.site 'site/:name', :controller => 'page', :action => 'show'
  map.home '/home', :controller => 'page', :action => 'index'
  map.root :home

  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
