class ArticlesController < ApplicationController
  before_filter :require_user

  # GET /articles
  # GET /articles.xml
  def index 
    @articles = current_user.articles

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = current_user.articles.find(params[:id]) rescue nil

    respond_to do |format|
      format.html do
        if @article.nil?
          flash[:error] = t('application.messages.article_not_found') 
          redirect_to articles_path
        end

      end
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id]) rescue nil
   
    if @article.nil?
      flash[:error] = t('application.messages.article_not_found')
      redirect_to articles_path
    end
  end 

  # POST /articles
  # POST /articles.xml
  def create 
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        @item = Item.create(:article_id => @article.id, :list_id => params[:list_id], :quantity => params[:item][:quantity], :price => 0) if params[:list_id]
        format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
        format.js { @list = @item.list}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to(articles_path, :notice => t('application.messages.article_updated_ok')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
    

    respond_to do |format|
      format.html do
        flash[:notice] = t('application.messages.article_destroyed_ok')
        redirect_to(articles_url)
      end
      format.xml  { head :ok }
    end
  end

  def search
    @list = List.find(params[:list_id])
    @articles = Article.for_list(@list).where("name LIKE ?", "%#{params[:query]}%")
    @new_item = Item.new
  end

end
