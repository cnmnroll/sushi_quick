class Admin::Manager::MerchandisesController < Admin::Manager::Base
	def new
		@merchandise = Merchandise.new
	end
	def create
		@merchandise = Merchandise.new(merchandise_params)
		if @merchandise.save
			redirect_to @merchandise, notice: '商品の登録が完了いたしました。'
		else
			render "new"
		end
	end

	def edit
		@merchandise = Merchandise.find(params[:id])
	end

	def update
		@merchandise = Merchandise.find(params[:id])
		@merchandise.assign_attributes(merchandise_params)
		if @merchandise.save
			redirect_to @merchandise, notice: '商品の編集が完了いたしました。'
		else
			render 'edit'
		end
	end

	def edit_select
		@merchandises = Merchandise.all
	end

	def update_select
		@merchandise = Merchandise.find(params[:merchandise])
		@merchandise.assign_attributes(merchandise_params)
		if @merchandise.save
			redirect_to @merchandise
		else
			render "edit_select"
		end
	end

	private
	def merchandise_params
		params.require(:merchandise).permit(:merchandise_name, :uploaded_image, :price, :stock, :category, :sub_category, :type_status, :recommend, :display)
	end
end
