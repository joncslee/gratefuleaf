class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user_time_zone

  helper_method :current_user

  private

  def set_user_time_zone
    Time.zone = current_user.time_zone if current_user && current_user.time_zone
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    @current_user = current_user_session && current_user_session.record
  end
end
