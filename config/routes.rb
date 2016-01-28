Rails.application.routes.draw do
	root "top#index"


	resource :contact, only: [:new, :create]

	resources :merchandises, only: [:index, :show] do
		collection do
			get :search
		end
		member do
			get :image
			post :create_review
		end
	end

	resources :reviews, only: [:create]

	resource :user, only: [:edit, :update, :new, :create, :show] do
		member do
			get :login
		end

		resources :orders, only: [:create, :index, :new, :edit, :update] do
			member do
				delete :delete_order
			end

			collection do
				match 'confirm', :to => 'orders#confirm', :via => [:get, :post]
				get :edit_address
			end



			resources :order_details, only: [:update] do
				member do
					delete :delete_detail
				end
			end
		end

		resource :shopping_cart, only: [] do
			resources :shopping_cart_details, only: [:index, :destroy, :update, :create], as: :detail, path: :details
		end
		# resource :shopping_cart, only: [:show, :edit, :destroy, :update, :create]
	end

	namespace :admin do
		namespace :manager do
			resources :merchandises, only: [:edit, :update, :new, :create, :show] do
				collection do
					get :edit_select
					patch :update_select
				end
			end
			resources :orders, only: [:index]
		end

		namespace :deliveryman do
			resources :orders, only: [:index, :update]
		end
	end
	resource :session, only: [:create, :destroy]
	match "*anything" => "top#not_found", via: [:get, :post, :patch, :delete]
end
