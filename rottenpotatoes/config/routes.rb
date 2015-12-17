Rottenpotatoes::Application.routes.draw do
  resources :movies do
    get "similar" => "movies#similar"
  end
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')

end