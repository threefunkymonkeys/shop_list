class ListsController < ApplicationController
  before_filter :require_user
  before_filter :set_current_list, :only => [:show, :edit]
  before_filter :require_owner, :only => [:show, :edit, :update, :destroy]

  # GET /lists
  # GET /lists.xml
  def index 
    @lists = current_user.lists.order "created_at DESC"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.xml
  def show
    @list = List.find(params[:id])
    @article = Article.new
    @item = Item.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @list }
      format.mobile
    end
  end

  # GET /lists/new
  # GET /lists/new.xml
  def new
    @list = List.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
    @article = Article.new
    @item = Item.new
    @articles = current_user.articles.for_list(@list).limit(10)
  end

  # POST /lists
  # POST /lists.xml
  def create
    @list = List.new(params[:list])
    @list.user = current_user

    respond_to do |format|
      if @list.save
        format.html { redirect_to(edit_list_path(@list), :notice => t('application.messages.list_created_ok')) }
        format.xml  { render :xml => @list, :status => :created, :location => @list }
        format.mobile { redirect_to(list_path(@list)) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
        format.mobile { render :action => "new" }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.xml
  def update
    @list = List.find(params[:id])
    @article = Article.new
    @item = Item.new

    old_name = @list.name

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to(edit_list_path(@list), :notice => t('application.messages.list_updated_ok')) }
        format.xml  { head :ok }
        format.mobile { redirect_to(@list, :notice => t('controllers.lists.list.renamed', :old => old_name, :new => @list.name)) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.xml
  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html do
        flash[:notice] = t('application.messages.list_destroyed_ok')
        redirect_to(lists_url)
      end
      format.xml  { head :ok }
      format.mobile { redirect_to(lists_url) }
    end
  end

  def empty
    @list = List.find(params[:id])
    @list.items.destroy_all
    redirect_to @list, :notice => t('controllers.lists.list.emptied', :name => @list.name)
  end

  def clone
    list = List.find(params[:id])
    @list = list.deep_clone
    current_list = @list
    flash[:notice] = t('application.messages.list_cloned_ok')
    redirect_to edit_list_path(@list)
  end

  def search
    @lists = current_user.lists.where("name LIKE ?", "%#{params[:query]}%")
    render 'index'
  end

  private
  def set_current_list
    self.current_list = current_user.lists.find(params[:id]) rescue nil if self.current_list.nil? or self.current_list.id != params[:id] 
    @list = self.current_list
  end
end
