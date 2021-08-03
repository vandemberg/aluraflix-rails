Rails.application.routes.draw do
  resources :categories do
    get("/videos", { to: "category_videos#index" })
  end

  resources :videos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
