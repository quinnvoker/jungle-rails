class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @product = Product.find params['product_id']
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @product, notice: "Review created!"
    else
      redirect_to @product, notice: "Review posting failed!"
    end
  end

  def review_params
    params.require(:review).permit(
      :rating, 
      :description,
      :product_id
    )
  end

  def require_login
    unless current_user
      flash[:alert] = "You must be logged in to post reviews!"
      redirect_to login_path
    end
  end
end
