class AchievementsController < ApplicationController
  def index
    @leaderboard_users = (User.order(points: :desc)).limit(10)

    @achievements = current_user.achievements.order(created_at: :desc)
  end
end
