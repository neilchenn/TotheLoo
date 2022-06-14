class DashboardController < ApplicationController
  def my_favorites
   # user's favorites
    @favorites = current_user.all_favorites
    
  end
end
