Rails.application.routes.draw do

  namespace :public do
    get 'homes/index'
  end
scope module: :public do
  get 'user/mypage' => "users#show"
  get 'user/information/edit' => "users#edit"
  patch 'user/information' => "users#update"

  resources :events, only: [:new, :index, :edit, :create, :update]
  get 'events/result' => "events#result"
end



namespace :admin do
  resources :categories
  resources :prefectures
  get 'users/index' => "users#index"
  get 'users/information/:id' => "users#show", as: "user"
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

root to: 'public/homes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
