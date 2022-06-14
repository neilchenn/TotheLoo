class DashboardController < ApplicationController
  def my_favorites
    # user's favorites
    @favorite_loos = current_user.favorite_loos
  end
end
