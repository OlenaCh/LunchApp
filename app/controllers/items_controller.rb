class ItemsController < ApplicationController
  # before_action :allow_admin_only, except: [:index, :show]

  def new
    @types = Type.all
    @item = Item.new
    @item.item_types.build
  end

  def create
  	@item = Item.create(item_params)
  	if @item.save
  	  flash[:success] = 'Item created!'
  	  redirect_to items_path
  	else
  	  flash[:error] = 'Something went wrong - no item created!'
  	  render 'new'
  	end
  end
  
  def index
    @items_list = sort_by_weekday_and_type
  end
  
  def edit
    @item = Item.find_by_id(params[:id])
  end
  
  def update
    @item = Item.find_by_id(params[:id])
    if @item.update(item_params)
      flash[:success] = 'Item updated!'
  	  redirect_to items_path
  	else
  	  flash[:error] = 'Something went wrong - no item updated!'
  	  render 'edit'
  	end
  end
  
  def destroy
    @item = Item.find_by_id(params[:id])
    @item.destroy
    flash[:success] = 'Item destroyed!'
    redirect_to items_path
  end

  private
  
  def sort_by_weekday_and_type
    items_list = {}
    Weekday.all.each do |weekday|
      types = {}
      Type.all.each do |type|
        types[type.title] = Item.includes(:types, :weekdays).where(:types => { :id => type.id }, 
                            :weekdays => { :id => weekday.id })
      end
      items_list[weekday.day] = types
    end
    items_list
  end

  def item_params
  	params.require(:item).permit(:title, :price, :image, item_types_attributes: :type_id)
  end
end