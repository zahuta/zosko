class HomeController < ApplicationController
  def index
    @leaderboard_users = (User.order(points: :desc)).limit(10)

    @user = current_user
    @streak = current_user.get_current_streak
    @categories = Category.all
  end
end
