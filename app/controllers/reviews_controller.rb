class ReviewsController < ApplicationController

  def new
    @reviewee = User.find(params[:user_id])
    @review = Review.new
  end

  def create
    @reviewee = User.find(params[:user_id])
    @review = Review.new(review_params)
    @review.reviewer = current_user
    @review.reviewee = @reviewee
    if @review.save
      redirect_to user_path(@reviewee)
    else
      render "new"
    end
  end


  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

end
