Rails.application.routes.draw do

  namespace :public do
    get 'home' => "homes#home"
    get 'about' => "homes#about"
  end
scope module: :public do
  get 'user/mypage' => "users#show"
  get 'user/information/edit' => "users#edit"
  patch 'user/information' => "users#update"
  get 'user/favorite' => "users#favorite", as: "user_favorite"
  get 'user/reserved' => "users#reserved", as: "user_reserved"
  get 'user/unsubscribe' => "users#unsubscribe", as: "user_unsubscribe"
  patch 'user/withdrawal' => 'users#withdrawal', as: 'user_withdrawal'
  get 'user/_notification' => 'users#notification', as: 'user_notification'
  get 'user/notification_read/:id' => 'users#notification_read', as: "user_notification_read"

  resources :events, only: [:new, :index, :edit, :show, :create, :update, :destroy] do
  get 'result' => "events#result"
   resource :favorites, only: [:create, :destroy]
   resources :comments, only: [:create, :destroy]
   resources :reservations, only: [:new, :show, :create, :destroy, :edit, :update]
  end

end

namespace :admin do
  resources :categories, only: [:new, :index, :edit, :create, :update, :destroy]
  resources :events, only: [:index, :show, :destroy] do
    get 'events/result' => "events#result", as: "result"
  end
  get 'users/index' => "users#index", as: "index"
  get 'users/information/:id' => "users#show", as: "user"
  get 'users/information/:id/edit' => "users#edit", as: "edit"
  patch 'users/information/:id/edit' => "users#update", as: "update"
end

# 顧客用
# URL /customers/sign_in ...
devise_for :user, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

root to: 'public/homes#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
