class ApplicationController < ActionController::Base
  protect_from_forgery

  @@current_list = nil

  helper_method :current_list

  def current_list
    @@current_list ||= session[:current_list]
  end

  protected
  def current_list=(list)
    session[:current_list] = list
    @@current_list = list
  end
end
