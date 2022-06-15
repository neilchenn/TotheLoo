class ReviewsController < ApplicationController
  def new
    @loo = Loo.find(params[:loo_id])
    @review = Review.new
  end

  def create
    @loo = Loo.find(params[:loo_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.loo_id = @loo.id
    if @review.save
      redirect_to loos_path
    else
      render loo_path(@loo)
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :loo_id, :cleanliness, :flushing_power,
                                   :ambience, :toilet_paper_soap, :star_rating, :report_a_problem)
  end
end
