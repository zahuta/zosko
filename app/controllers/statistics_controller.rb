class StatisticsController < ApplicationController
  def index
    @leaderboard_users = (User.order(points: :desc)).limit(10)

    @hardest_tasks = Task.all.sort_by(&:get_success_rate).take(5)
    @users = User.all
    @tasks = Task.all
  end
end
