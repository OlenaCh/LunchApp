class ItemsController < ApplicationController
  def create
  	Item.create(item_params)
  	redirect_to items_path
  end
  
  def index
    render 'index', locals: set_locals()
  end
  
  def update
    item = Item.find_by_id(params[:id])
    item.update(item_params)
    redirect_to items_path
  end
  
  def destroy
    item = Item.find_by_id(params[:id])
    item.destroy
    redirect_to items_path
  end

  private
  
  def set_locals(item = nil)
   { types: Item.types.values, items: Item.all, item: item ? item : Item.new }
  end

  def item_params
  	params.require(:item).permit(:item_type, :title, :price, :image)
  end
end