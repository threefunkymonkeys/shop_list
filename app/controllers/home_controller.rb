class HomeController < ApplicationController

  def index
    redirect_to lists_path unless current_user_session.nil?
    @user_session = UserSession.new
  end

end
