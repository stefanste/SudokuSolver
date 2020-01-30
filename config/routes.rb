Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sudoku#index'
  get 'solve'  => 'sudoku#solve'
  get 'new'    => 'sudoku#new'

  resources :tweets
  resources :users
end
