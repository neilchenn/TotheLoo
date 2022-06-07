class LoosController < ApplicationController
  def index
    @loos = Loo.all
  end

  def show
    @loo = Loo.find(params[:id])
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
