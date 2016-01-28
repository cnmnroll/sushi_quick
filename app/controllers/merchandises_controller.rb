class MerchandisesController < ApplicationController
	before_action :authenticate_user, only: [:create_review]
	def show
		@merchandise = Merchandise.find(params[:id])
		@reviews = @merchandise.reviews.paginate(page: params[:page], per_page: 5)
		@relevances = @merchandise.relevances.getRelevance
		render "detail"
	end

	def search
		@categories = Category.all
		@sub_categories = SubCategory.all
		@user = current_user
		@merchandises = Merchandise.display
		if params[:search]
			@merchandises = Merchandise.all.select_display(params[:search][:display]).category(params[:search][:category]).sub_category(params[:search][:sub_category]).type_status(params[:search][:type_status]).search(params[:search][:content])
		end
		@merchandises = @merchandises.paginate(page: params[:page], per_page: 12)
	end

	def create_review
		review = Review.new(review_params)
		review.merchandise = Merchandise.find(params[:id])
		review.user = @user
		if review.save
			redirect_to merchandise_path(params[:id]), method: :get, notice: '投稿が完了いたしました。'
		else
			redirect_to merchandise_path, method: :get
		end
	end


	def image
		@merchandise = Merchandise.find(params[:id])
		if params[:format].in?(["jpg", "png", "gif"])
			send_image
		else
			nil
		end
	end

	private
	def send_image
		send_data @merchandise.data, type: @merchandise.content_type, disposition: "inline"
	end

	def review_params
		params.require(:review).permit(:score, :title, :content)
	end
end

