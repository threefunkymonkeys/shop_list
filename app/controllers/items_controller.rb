class ItemsController < ApplicationController
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

  def remove
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.js
    end
  end

end
