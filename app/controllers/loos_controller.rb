class LoosController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  skip_before_action :show_navbar!, only: :index

  def index
    @loos = Loo.all
    # @loos = Loo.near([params[:latitude], params[:longitude]], 20, units: :km)
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
    # fetch_average_reviews(@loo) if @loo.reviews.present?
  end

  def new
    @loo = Loo.new
  end

  def create
    @loo = Loo.new(loo_params)
    @loo.user_id = current_user.id
    if @loo.save
      redirect_to root_path
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
    @loo = Loo.find(params[:id])

    # @loo = Loo.near([params[:latitude], params[:longitude]], 20, units: :km).first
  end

  def favourite
    @loo = Loo.find(params[:id])
    current_user.favorite @loo #might need a bracket
    redirect_back(fallback_location: loo_path(@loo))
  end

  def unfavourite
    @loo = Loo.find(params[:id])
    current_user.unfavorite @loo
    redirect_back(fallback_location: loo_path(@loo))
  end

  def nearest_loo
    # raise
    @nearest_loo = Loo.near([params[:latitude], params[:longitude]], 10000).first
    @markers = [@nearest_loo]
    redirect_to loo_path(@nearest_loo)
    # redirect_to root_path
  end

  private

  def loo_params
    params.require(:loo).permit(:facility_type, :name, :address, :latitude,
                                :longitude, :parking, :accessible, :baby_change,
                                :male, :female, :unisex, :opening_hours, :user_id)
  end
end
