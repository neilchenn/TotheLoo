class LoosController < ApplicationController
  skip_before_action :authenticate_user!, except: [:new, :favorite, :unfavorite, :create, :destroy]
  skip_before_action :show_navbar!, only: :index

  def index
    @loos = Loo.all
    if params[:query].present?
      @loos = Loo.geocoded.search_by_loo_fields(params[:query])
    else
      @loos = Loo.geocoded
    end
    @markers = @loos.map do |loo| {
      lat: loo.latitude,
      lng: loo.longitude,
      info_window: render_to_string(partial: "info_window", locals: { loo: loo }),
      image_url: helpers.asset_url("loo.png")
    }
    end
  end

  def show
    @loo = Loo.find(params[:id])
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
  end

  def favourite
    @loo = Loo.find(params[:id])
    current_user.favorite(@loo)
    redirect_back(fallback_location: loo_path(@loo))
  end

  def unfavourite
    @loo = Loo.find(params[:id])
    current_user.unfavorite(@loo)
    if request.path == "/my_favorites"
      redirect_to my_favorites_path
    else
      redirect_back(fallback_location: loo_path(@loo))
    end
  end

  def nearest_loo
    @nearest_loo = Loo.near([params[:latitude], params[:longitude]], 10000).first
    @markers = [@nearest_loo]
    redirect_to loo_path(@nearest_loo)
  end

  private

  def loo_params
    params.require(:loo).permit(:facility_type, :name, :address, :latitude,
                                :longitude, :parking, :accessible, :baby_change,
                                :male, :female, :unisex, :opening_hours, :user_id)
  end
end
