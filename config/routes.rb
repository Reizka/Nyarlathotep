Rails.application.routes.draw do
  resources :categories
  authenticated :user, ->(user) {user.admin?} do
    get 'admin', to:'admin#index'
    get 'admin/articles'
    get 'admin/comments'
    get 'admin/users'
    get 'admin/show_article/:id', to:'admin#show_article', as: 'admin_article'
  end

  get 'search', to:'search#index'
  get 'about', to: 'pages#about'
  get 'home', to: 'pages#home'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root "articles#index"

  resources :articles

  resources :after_signup

  resources :articles do
    resources :comments
  end


 

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
