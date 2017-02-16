class ItemsController < ApplicationController
  def new
    new_or_edit 'new'
  end
  
  def create
    item = Item.new(item_params)
    redirect_to items_path and return false if item.save!
  	new_or_edit 'new'
  end
  
  def index
    render 'index', locals: { items: Item.all.page(params[:page]) }
  end
  
  def edit
    new_or_edit('edit', Item.find(params[:id]))
  end
  
  def update
    item = Item.find_by_id(params[:id])
    redirect_to items_path and return false if item.update(item_params)
    new_or_edit('edit', item)
  end
  
  def destroy
    item = Item.find_by_id(params[:id])
    item.destroy
    redirect_to items_path
  end

  private
  
  def new_or_edit(page, item = nil)
   render page, locals: { types: Item.types.values, 
                          item: item ? item : Item.new }
  end

  def item_params
  	params.require(:item).permit(:item_type, 
  	                             :title, 
  	                             :price, 
  	                             :description, 
  	                             :fat, 
  	                             :carbohydrate,
  	                             :protein, 
  	                             :calorie, 
  	                             :image)
  end
end