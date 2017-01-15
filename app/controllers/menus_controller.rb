class MenusController < ApplicationController
  # before_action :allow_admin_only, except: [:index, :show]

  def new
    new_or_edit 'new'
  end

  def create
  	menu = Menu.new(menu_params)
  	redirect_to menus_path and return false if menu.save
  	new_or_edit 'new'
  end
  
  def index
    @menus = Menu.all
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
    render page, locals: { fc_items: Item.first_courses, 
                           mc_items: Item.main_courses,
                           drink_items: Item.drinks,
                           menu: menu ? menu : Menu.new }
  end

  def menu_params
  	params.require(:menu).permit(:weekday, :f_course_id_1, :f_course_id_2,
  	                             :f_course_id_3, :f_course_id_4, :m_course_id_1,
  	                             :m_course_id_2, :m_course_id_3, :m_course_id_4, 
  	                             :drink_id_1, :drink_id_2, :drink_id_3, 
  	                             :drink_id_4)
  end
end