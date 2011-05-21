class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale, :prepare_for_mobile, :save_location
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

  def require_owner
    unless current_user.list_ids.include? params[:id].to_i
      flash[:error] = t('application.messages.forbidden')
      redirect_to lists_path
    end
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

  def save_location
    session[:back_to] = request.path unless request.params[:controller] == "user_sessions"
  end

  def require_user
    unless current_user
      flash[:error] = t('application.messages.forbidden')
      redirect_to root_path
    end
  end

  def require_admin_or_owner
    render :file => "public/404.html", :status => :not_found if current_user.nil? or (!current_user.admin? and (current_user.id != params[:id].to_i))
  end

  def require_no_user
    if current_user
      flash[:error] = t('application.messages.need_logout')
      redirect_to root_path
    end
  end

  def redirect_back_or_default(path)
    if session[:back_to]
      redirect_to session[:back_to]
    else
      redirect_to path
    end
  end

  def set_locale
    # This is not the optimal way, it's better to use routes scopes I think
    # Also locale is not stored in session so far
    I18n.locale = params[:locale].to_sym if params[:locale]
  end
end
