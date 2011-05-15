class ItemsController < ApplicationController
  before_filter :require_user

  def new
    @item = Item.new(:list_id => params[:list_id])
    @list = List.find(params[:list_id])
    @articles = Article.select([:id, :name]).order(:name)

    respond_to do |format|
      format.mobile
    end
  end

  #
  # Didn't aliased it to #add because I tried it and didn't worked, and I
  # don't really know what that method does.
  # And the logic seems quite simplistic :P
  def create
    @list = List.find(params[:item][:list_id])
    params[:item][:price] = params[:item][:price].nil? ? 0 : (params[:item][:price].to_f * 100).to_i

    article_id = unless !params[:article] or params[:article][:name].blank?
                   article = Article.find_by_name(params[:article][:name])
                   if article.nil?
                     Article.create!(params[:article]).id
                   else
                     article.id
                   end
                 else
                   Article.find(params[:item][:article_id]).id rescue nil
                 end

    @item = @list.items.find_by_article_id(article_id)

    if @item.nil?
      @item = Item.create(params[:item].merge({ :article_id => article_id }))
    else
      @item.quantity = @item.quantity + params[:item][:quantity].to_i
      @item.update_attribute(:price, params[:item][:price]) unless @item.price == params[:item][:price]
    end

    if @item.save
      @item.article.update_attribute(:last_price, @item.price) unless @item.price == @item.article.last_price
      if request.xhr?
        @articles = current_user.articles.for_list(@list)
        @new_item = Item.new
        render :create
      else
        redirect_to(list_path(@list), :notice => t('controllers.items.item.created', :count => @item.quantity, :name => @item.article.name))
      end
    else
      @articles = Article.select([:id, :name]).order(:name)
      render :action => "new"
    end
  end

  def edit
    @item = Item.find(params[:id])
    @list = @item.list
  end

  def update
    @item = Item.find(params[:id])

    if params[:item][:price]
      params[:item][:price] = (params[:item][:price].to_f * 100).to_i
    end

    @item.update_attributes(params[:item])
    @item.article.update_attribute(:last_price, @item.price)

    unless params[:article].nil? or params[:article][:id].nil?
      article = Article.find(params[:article][:id])
      article.update_attributes(params[:article])
    end

    if request.xhr?
      render :json => @item.to_json
    else
      redirect_to list_path(@item.list)
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @list = @item.list
    @item.destroy
    @new_item = Item.new
    @articles = current_user.articles.for_list(@list).limit(10)

    respond_to do |format|
      format.js
      format.mobile { redirect_to @list, :notice => t('controllers.items.item.destroyed', :name => @item.article.name) }
      format.html {
        respond_with @list, :notice => "Item removed successfully"
      }
    end
  end

end
