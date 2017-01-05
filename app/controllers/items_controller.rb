class ItemsController < ApplicationController
  # before_action :allow_admin_only, except: [:index, :show]

  def new
    new_or_edit 'new'
  end

  def create
    type = Type.find_by_id(params[:type])
  	item = type.items.build(item_params)
  	redirect_to items_path and return false if item.save
  	new_or_edit 'new'
  end
  
  def index
    @items = Item.all
  end
  
  def edit
    new_or_edit('edit', Item.find_by_id(params[:id]))
  end
  
  def update
    item = Item.find_by_id(params[:id])
    item = change_item_type item if check_for_type_difference item.type_id
    redirect_to items_path and return false if item.update(item_params)
    new_or_edit('edit', item)
  end
  
  def destroy
    item = Item.find_by_id(params[:id])
    item.destroy
    redirect_to items_path
  end

  private
  
  def change_item_type item
    type = Type.find_by_id(item.type_id)
    type.items.delete(Item.find_by_id(item.id)) if type
    type = Type.find_by_id(params[:type])
    type.items << item
    item
  end
  
  def check_for_type_difference id
    return true if id != params[:type] && params[:type].present?
    false
  end
  
  def new_or_edit(page, item = nil)
    render page, locals: { types: Type.all, item: item ? item : Item.new }
  end

  def item_params
  	params.require(:item).permit(:title, :price, :image)
  end
end