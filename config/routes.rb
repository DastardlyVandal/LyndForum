Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users do
      resources :votes
  end

  root "home#index"

  resources :board do
      resources :rules
          resources :streams do
          resources :post do
              resources :votes
          end
      end
  end

  resources :announcements

  get '/board/:board_id/streams/:streams_id/post/:id/edit', to: 'post#edit'
  post '/board/:board_id/streams/:stream_id/post/:post_id/votes/create', to: 'votes#create'
  post '/board/:board_id/streams/sticky', to: 'streams#sticky'
  post '/board/:board_id/streams/lock', to: 'streams#lock'
  post '/board/:board_id/streams/delete', to: 'streams#delete'
  post '/board/:board_id/streams/:stream_id/post/delete', to: 'post#delete'
  post '/board/:board_id/streams/:stream_id/post/ignore', to: 'post#ignore'
  post '/users/makeMod', to: 'users#make_mod'
  get '/board/:board_id/moderation', to: 'board#moderation'
  get '/board/:board_id/streams/:streams_id/post/:id/report', to: 'post#report'
  patch '/board/:board_id/streams/:streams_id/post/:id/report', to: 'post#report_post'
  post 'board/lock', to: 'board#lock'
  post 'board/delete', to: 'board#delete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
