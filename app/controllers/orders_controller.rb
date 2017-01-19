class OrdersController < ApplicationController
  def new
    @order = Order.new
    @first_courses = Order.first_courses_for_today
    @main_courses = Order.main_courses_for_today
    @drinks = Order.drinks_for_today
  end
  
  def index
    @orders_list = sort_by_weekday_and_user
  end
  
  def today_index
    @orders_list = orders_for_today
    @orders_total = total_sum_for_today @orders_list
  end
  
  def create
    @order = current_user.orders.create(order_params)
    @order.update(total: count_total(order_params))
    if @order.save
  	  flash[:success] = 'Order created!'
  	  redirect_to items_path
  	else
  	  flash[:alert] = 'Something went wrong - no order created!'
  	  render 'new'
  	end
  end
  
  def show
    @order = Order.find_by_id(params[:id])
    @first_course = Item.find_by_id(@order.first_course_id)
    @main_course = Item.find_by_id(@order.main_course_id)
    @drink = Item.find_by_id(@order.drink_id)
  end
  
  private
  
  def orders_for_today
    orders = {}
    User.where(:admin => false).each do |user|
      user_orders = Order.includes(:weekdays).where(:weekdays => { :order_number => Time.now.wday + 1 })
      orders[user.name] = user_orders unless user_orders.empty?
    end
    orders
  end
  
  def total_sum_for_today orders
    total = 0.0
    orders.each do |key, value|
      value.each do |order|
        total = total + order.total
      end
    end
    total
  end
  
  def sort_by_weekday_and_user
    orders_list = {}
    Weekday.all.each do |weekday|
      orders = {}
      User.where(:admin => false).each do |user|
        user_orders = Order.includes(:weekdays).where(:weekdays => { :id => weekday.id }, 
                                                      :user_id => user.id)
        orders[user.name] = user_orders unless user_orders.empty?              
      end
      orders_list[weekday.day] = orders
    end
    orders_list
  end
  
  def count_total items
    prices = []
    items.each do |price|
      prices << Item.find_by_id(price).price
    end
    prices.inject(:+)
  end
  
  def order_params
    params.require(:order).permit(:first_course_id, :main_course_id, :drink_id)
  end
end