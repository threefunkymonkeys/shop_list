class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile
  helper_method :current_user_session, :current_user

  @@current_list = nil

  helper_method :current_list, :mobile_device?

  def current_list
    @@current_list ||= session[:current_list]
  end

  protected
  def current_list=(list)
    session[:current_list] = list
    @@current_list = list
  end

  private
  def mobile_device?
    puts request.user_agent
    if session[:is_mobile]
      session[:is_mobile] == "1"
    else
      mobile_user_agent?
    end
  end

  def prepare_for_mobile
    session[:is_mobile] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

  def mobile_user_agent?
    request.user_agent =~ /Mobi|Mobile|webOS|SymbianOS/
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def require_no_user
    #redirect_to root_path if current_user
  end

  def redirect_back_or_default(path)
    if session[:redirect_to]
      redirect_to session[:redirect_to]
    else
      redirect_to path
    end
  end
end
