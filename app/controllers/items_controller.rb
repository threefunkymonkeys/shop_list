class ItemsController < ApplicationController
  def new
    @item = Item.new(:list_id => params[:list_id])
    @list = List.find(params[:list_id])
    @articles = Article.select([:id, :name]).order(:name)

    respond_to do |format|
      format.mobile
    end
  end

  def add
    @item = Item.create(:article_id => params[:article_id], :list_id => params[:list_id], :price => 0)
    @list = @item.list
    @articles = Article.for_list(@list).limit(10)

    respond_to do |format|
      format.js
      format.html do
        respond_with @list, :notice => "Item created successfully" 
      end
    end
  end

  #
  # Didn't aliased it to #add because I tried it and didn't worked, and I
  # don't really know what that method does.
  # And the logic seems quite simplistic :P
  def create
    @list = List.find(params[:item][:list_id])

    article_id = unless params[:article][:name].blank?
                   article = Article.find_by_name(params[:article][:name])
                   if article.nil?
                     Article.create!(params[:article]).id
                   else
                     article.id
                   end
                 else
                   Article.find(params[:item][:article_id])
                 end

    @item = @list.items.find_by_article_id(article_id)

    if @item.nil?
      @item = Item.create(params[:item].merge({ :article_id => article_id }))
    else
      @item.quantity = @item.quantity + params[:item][:quantity].to_i
      # TODO: Update the price? Raise an error?
      # @item.price    = @item.price    + params[:item][:price].to_f
    end

    if @item.save
      redirect_to(list_path(@list), :notice => t('controllers.items.item.created', :count => @item.quantity, :name => @item.article.name))
    else
      render :action => "edit"
    end
  end

  def edit
    @item = Item.find(params[:id])
    @list = @item.list
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(params[:item])

    redirect_to list_path(@item.list)
  end

  def destroy
    @item = Item.find(params[:id])
    @list = @item.list
    @item.destroy

    respond_to do |format|
      format.js
      format.mobile 
      format.html {
        respond_with @list, :notice => "Item removed successfully"
      }
    end
  end

end
