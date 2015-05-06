Rails.application.routes.draw do
  devise_for :users
    resources :posts do
    	# the upvote and downvote method are defined in the controller
    	member do
    		get 'like', to: 'posts#upvote'
    		get 'dislike', to: 'posts#downvote'
    	end
    	resources :comments
    end

    root 'posts#index'
end
