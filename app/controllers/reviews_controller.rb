class ReviewsController < ApplicationController
  def create
    @loo = Loo.find(params[:loo_id])
    @review = Review.new(review_params)
    if @review.save
      redirect_to loo_path(@loo)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :loo_id, :cleanliness, :flushing_power,
                                   :ambience, :toilet_paper_soap, :report_a_problem)
  end
end
