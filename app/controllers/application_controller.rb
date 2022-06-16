class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :show_navbar!

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def show_navbar!
    @show_navbar = true
  end
end
