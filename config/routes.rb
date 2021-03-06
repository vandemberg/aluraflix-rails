Rails.application.routes.draw do
  # authentication
  resources :users, param: :_username
  post '/login', to: 'authentication#login'

  resources :categories do
    get("/videos", { to: "category_videos#index" })
  end

  get("/videos/free", { to: "videos#free"})
  resources :videos
end
