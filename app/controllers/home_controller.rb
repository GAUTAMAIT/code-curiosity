class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_path
      return
    end
  end

  def leaderboard
    @subscriptions = current_round.subscriptions
                                  .where(:points.gt => 0)
                                  .order(points: :desc)
                                  .page(1).per(5)

    if user_signed_in?
      render layout: 'application'
    else
      render layout: 'info'
    end
  end

  def points
    @points = current_round.subscriptions
                                 .where(:points.gt => 0)
                                 .order(points: :desc)
                                 .pluck(:points).uniq

    if current_user
      @user_points = current_user.current_subscription.try(:points)
    end

    if user_signed_in?
      render layout: 'application'
    else
      render layout: 'info'
    end
  end

end
