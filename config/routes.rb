Rails.application.routes.draw do
  devise_for :admin_users

  root 'tickets#new'

  resources :tickets, only: [:new, :create, :show], constraints: {id: /\d+/}

  scope module: 'admin' do
    resources :tickets, only: [:index, :edit, :update] do
      collection do
        get :search, :filter
      end
    end
    resources :replies, only: :create
    resources :statuses, only: [:new, :create]
  end
end
