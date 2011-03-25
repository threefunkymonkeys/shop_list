class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:index, :show, :edit, :update]
  before_filter :require_admin_or_owner
  
  def index
    @users = User.where("id <> ?", current_user.id)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = t('application.messages.user_register_ok')
      UserSession.create(@user)
      redirect_to lists_path
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = t('application.messages.password_changed_ok')
      redirect_to lists_path
    else
      render :action => :edit
    end
  end

end
