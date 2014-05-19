Gamified::Application.routes.draw do
  root 'home#index'

  # Hacks
  get '/make_admin' => 'users#make_admin', as: 'make_admin'
  get '/build_badges' => 'badges#build_badges', as: 'build_badges'

  # Admin
  namespace :admin do
    resources :tasks, except: [:show]
    resources :categories, except: [:show]
  end

  # Users
  get '/sign_up' => 'users#new', as: 'signup'
  get '/forgotten_password' => 'password_resets#new', as: 'forgotten_password'
  resources :users, except: [:index, :show]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # Sessions
  get '/sign_in' => 'user_sessions#new', as: 'login'
  get '/sign_out' => 'user_sessions#destroy', as: 'logout'
  resources :user_sessions, only: [:new, :create, :destroy]

  # Tasks
  get '/tasks/next' => 'tasks#next', as: 'next_task'
  get '/tasks/:id/do' => 'tasks#do', as: 'do_task'
  patch '/tasks/:id/evaluate' => 'tasks#evaluate', as: 'evaluate_task'
  get '/tasks/:id/self_evaluate' => 'tasks#self_evaluate', as: 'self_evaluate_task'

  # Achievements
  get '/achievements' => 'achievements#index', as: 'achievements'

  # Statistics
  get '/statistics' => 'statistics#index', as: 'statistics'
end
