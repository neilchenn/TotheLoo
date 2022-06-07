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
    @loos = Loo.find(params[:id])
  end

  def update
  end

  def destroy
    @booking.destroy
  end

  def navigation
  end

  def favourite
  end

  def unfavourite
  end
end
