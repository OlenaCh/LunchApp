class MenusController < ApplicationController
  def new
    new_or_edit 'new'
  end

  def create
  	menu = Menu.new(weekday: menu_params[:weekday])
  	
  	redirect_to menus_path and return false if menu.save
  	new_or_edit 'new'
  end
  
  def index
    render 'index', locals: { menus: Menu.all }
  end
  
  def edit
    new_or_edit('edit', Menu.find_by_id(params[:id]))
  end
  
  def update
    menu = Menu.find_by_id(params[:id])
    redirect_to menus_path and return false if menu.update(menu_params)
    new_or_edit('edit', menu)
  end
  
  def destroy
  end

  private
  
  def new_or_edit(page, menu = nil)
    render page, locals: { weekdays: Menu.weekdays.values,
                           fc_items: Item.first_courses, 
                           mc_items: Item.main_courses, drink_items: Item.drinks }
  end

  def menu_params
  	params.require(:menu).permit(:weekday, :item_id)
  end
end