Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users

  root "home#index"

  resources :home do
      resources :users
  end

  # routes for Boards
  match 'board', to: 'board#show', via: :get

  resources :board do
      resources :streams do
          resources :post
      end
  end

  resources :announcements

  get 'streams/index'
  get '/board/:board_id/streams/:streams_id/post/:id/edit', to: 'post#edit'
  get '/users/:id/reports', to: 'users#reports'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
