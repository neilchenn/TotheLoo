class User::LocationsController < ApplicationController

  def update

    session[:latitude] = params[:latitude].to_f
    session[:longitude] = params[:longitude].to_f
  end
end
