class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t('controllers.user_session.login_successful')
      redirect_back_or_default lists_path
    else
      render "new"
    end
  end

  def destroy
    current_user_session.destroy if current_user
    redirect_to root_path, :notice => t('controllers.user_session.logout_successful')
  end
end
