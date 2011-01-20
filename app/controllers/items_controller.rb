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

  def edit
    @item = Item.find(params[:id])
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
