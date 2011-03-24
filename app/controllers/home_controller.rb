class HomeController < ApplicationController

  def index
    redirect_to lists_path unless current_user_session.nil?
    @user_session = UserSession.new
  end

  def no_ie
    @message = t('application.messages.no_ie')
  end

end
