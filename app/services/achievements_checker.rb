class AchievementsChecker
  def initialize user, event
    @user = user
    @event = event

    @achieved = false
  end

  def check
    case @event

    when 'registered'
      award 'registration_completed'

    when 'logged_in'

    when 'task_answered'
      award 'first_task_answered'

      if @user.points >= 1000
        award 'thousand_points'

        if @user.points >= 10000
          award 'ten_thousand_points'
        end
      end

      streak = @user.get_current_streak
      if streak >= 5
        award 'five_day_streak'

        if streak >= 10
          award 'ten_day_streak'
        end
      end
    end

    return @achieved
  end

  def award badge_name
    badge = Badge.find_by(name: badge_name)
    if badge
      achievement = @user.achievements.find_or_initialize_by(badge: badge)
      if achievement.new_record?
        achievement.save
        @achieved = true
      end
    end
  end
end
