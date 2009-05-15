ActionController::Routing::Routes.draw do |map|
  map.resources :users, :as => :volunteers, :except => :destroy
  map.signup '/signup', :controller => 'users', 
                        :action => 'new'                      
  
  map.resource :user_session, :only => [:new, :create, :destroy]
  
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', 
                        :action => 'destroy', 
                        :conditions => { :method => :delete }
                        
  map.root :login                      
  
    
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
