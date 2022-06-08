class LoosController < ApplicationController
  def index
    @loos = Loo.all
    # @loos = policy_scope(Loo)

    if params[:query].present?
      @loos = Loo.geocoded.search_by_loo_fields(params[:query])
    else
      @loos = Loo.geocoded
    end
    @markers = @loos.map do |loo| {
      lat: loo.latitude,
      lng: loo.longitude,
      info_window: render_to_string(partial: "info_window", locals: { loo: loo }), # can someone explain this line
      image_url: helpers.asset_url("loo.png")
    }
    end
  end

  def show
    @loo = Loo.find(params[:id])
    @reviews = @loo.reviews
    @average_cleanliness_rating = 0
    @average_flushing_power_rating = 0
    @average_ambience_rating = 0
    @average_toilet_paper_soap_rating = 0
    @average_star_rating = 0
    unless @reviews.blank?
      @reviews.each do |review|
        @average_cleanliness_rating += review.cleanliness
        @average_flushing_power_rating += review.flushing_power
        @average_ambience_rating += review.ambience
        @average_toilet_paper_soap_rating += review.toilet_paper_soap
      end
      @average_cleanliness_rating = (@average_cleanliness_rating / @reviews.count).round(1)
      @average_flushing_power_rating = (@average_flushing_power_rating / @reviews.count).round(1)
      @average_ambience_rating = (@average_ambience_rating / @reviews.count).round(1)
      @average_toilet_paper_soap_rating = (@average_toilet_paper_soap_rating / @reviews.count).round(1)
      @average_star_rating = ((@average_cleanliness_rating + @average_flushing_power_rating + @average_ambience_rating + @average_toilet_paper_soap_rating)/4).round(1)
    end
  end

  def new
    @loo = Loo.new
  end

  def create
    @loo = Loo.new(loo_params)
    if @loo.save
      redirect_to loos_path
    else
      render :new
    end
  end

  def edit
    @loo = Loo.find(params[:id])
  end

  def update
  end

  def destroy
    @booking.destroy
  end

  def navigation
  end

  def favourite
    @loo = Loo.find(params[:id])
    current_user.favourite(@loo)
  end

  def unfavourite
    @loo = Loo.find(params[:id])
    current_user.unfavourite(@loo)
  end

  private

  def loo_params
    params.require(:loo).permit(:facility_type, :name, :address, :latitude,
                                :longitude, :parking, :accessible, :baby_change,
                                :male, :female, :unisex, :opening_hours, :user_id)
  end
end
