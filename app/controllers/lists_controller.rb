class ListsController < ApplicationController
  before_filter :set_current_list, :only => [:show, :edit]
  # GET /lists
  # GET /lists.xml
  def index
    @lists = List.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.xml
  def show
    #@list = List.find(params[:id])

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
    @articles = Article.for_list(@list).limit(10)
  end

  # POST /lists
  # POST /lists.xml
  def create
    @list = List.new(params[:list])

    respond_to do |format|
      if @list.save
        format.html { redirect_to(edit_list_path(@list), :notice => 'List was successfully created.') }
        format.xml  { render :xml => @list, :status => :created, :location => @list }
        format.mobile { redirect_to(list_path(@list), :notice => 'List was successfully created.') }
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

    old_name = @list.name

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to(@list, :notice => 'List was successfully updated.') }
        format.xml  { head :ok }
        format.mobile { redirect_to(@list, :notice => "#{old_name} => #{@list.name}") }
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
      format.html { redirect_to(lists_url) }
      format.xml  { head :ok }
    end
  end

  def empty
    @list = List.find(params[:id])
    @list.items.destroy_all

    redirect_to @list, :notice => 'List emptied!'
  end
  
  private
  def set_current_list
    self.current_list = List.find(params[:id]) if self.current_list.nil? or self.current_list.id != params[:id]
    @list = self.current_list
  end
end
