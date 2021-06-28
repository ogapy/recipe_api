Rails.application.routes.draw do
  scope module: :api do
    resources :recipes
  end
end
