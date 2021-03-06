HeisenBugDev::Application.routes.draw do
  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  root 'home#home'

  namespace :users do
    put 'update_token', :to => 'token#update'
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  namespace :projects do
    get :autocomplete_user_name
    delete :remove_user
  end

  resources 'rasterizer', :only => [:create]

  resources 'users'
  resources 'flashes',    :only => [:index]

  resources 'builds', :only => [:create]

  get '/documentation', :to => 'documentation#index'
  get '/documentation/:id', :to => 'documentation#show', :as => :documentation_show
  post '/builds/:id', :to => 'builds#artifact_upload', :as => :artifact_upload

  resources 'projects' do
    resources 'builds', :except => [:create] do
      resources 'artifacts', :only => [] do
        get 'download', :to => 'builds#download', :as => :download
      end

      get 'download', :to => 'builds#download', :as => :download
    end
    get 'download', :to => 'builds#download', :as => :download
    get :downloads

    scope :module => :wiki do
      resources 'wikis' do
        resources 'articles'
      end
      get ':id/refresh_wiki', :to => 'wikis#update_wiki', :as => :refresh_wiki
    end
  end
end
