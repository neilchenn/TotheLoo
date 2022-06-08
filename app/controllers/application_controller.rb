class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :show_navbar!

  private

  def show_navbar!
    @show_navbar = true
  end
end
