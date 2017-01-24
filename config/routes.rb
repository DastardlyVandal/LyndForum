Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users do
      resources :votes
  end

  root "home#index"

  resources :home do
      resources :users
  end

  # routes for Boards
  match 'board', to: 'board#show', via: :get

  resources :board do
      resources :streams do
          resources :post do
              resources :votes
          end
      end
  end

  resources :announcements

  get 'streams/index'
  get '/board/:board_id/streams/:streams_id/post/:id/edit', to: 'post#edit'
  post '/board/:board_id/streams/:stream_id/post/:post_id/votes/create', to: 'votes#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
