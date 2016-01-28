class ReviewsController < ApplicationController
	before_action :authenticate_user
	def create
		review = Review.new(create_review)
		review.merchandise = Merchandise.find(params[:id])
		review.user = current_user
		if review.save? && review.user.save? && review.merchandise.save?
			redirect_to merchandise_path(@merchandise), method: :get, notice: '投稿が完了いたしました。'
		else
			redirect_to merchandise_path, method: :get
		end
	end

	private
	def create_review
		params.require(:review).permit(:score, :title, :content)
	end
end
