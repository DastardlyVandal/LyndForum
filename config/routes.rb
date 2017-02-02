Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users do
      post :make_mod
      post :ban
      resources :votes
  end

  root "home#index"

  resources :board do
      post :lock
      resources :rules
          resources :streams do
              post :sticky
              post :lock
          resources :post do
              post :ignore
              resources :votes
          end
      end
  end

  resources :announcements

  get '/board/:board_id/streams/:streams_id/post/:id/edit', to: 'post#edit'
  post '/board/:board_id/streams/:stream_id/post/:post_id/votes/create', to: 'votes#create'
  get '/board/:board_id/moderation', to: 'board#moderation'
  get '/board/:board_id/streams/:streams_id/post/:id/report', to: 'post#report'
  patch '/board/:board_id/streams/:streams_id/post/:id/report', to: 'post#report_post'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
