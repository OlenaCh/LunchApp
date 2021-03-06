class ItemsController < ApplicationController
  before_action :authenticate_admin!, except: [:index]

  def new
    new_or_edit 'new'
  end
  
  def create
    item = Item.new(item_params)
    redirect_to items_path and return false if item.save
  	redirect_to session.delete(:return_to)
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
    redirect_to session.delete(:return_to)
  end
  
  def destroy
    item = Item.find_by_id(params[:id])
    item.destroy if item
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