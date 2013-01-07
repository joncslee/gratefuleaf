module ApplicationHelper

  # calculates percentage of daily/weekly goal, to pass to progress bar
  def goal_percentage

    progress = 0
    total = 1
    percentage = 0

    unless current_user.goal_type == User::NO_LEAF_GOAL
      progress = current_user.goal_type == User::DAILY_LEAF_GOAL ? current_user.daily_leaves.size : current_user.weekly_leaves.size
      total = current_user.goal_type == User::DAILY_LEAF_GOAL ? current_user.daily_leaf_goal : current_user.weekly_leaf_goal
    end

    percentage = (progress * 100) / total

    percentage
  end
end
