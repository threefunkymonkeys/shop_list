class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile

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

end
