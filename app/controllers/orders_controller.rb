class OrdersController < ApplicationController
  def index
    # @orders = sort_by_weekday_and_user
  end
  
  def create
  #   @order = current_user.orders.create(order_params)
  #   @order.update(total: count_total(order_params))
  #   if @order.save
  # 	  flash[:success] = 'Order created!'
  # 	  redirect_to items_path
  # 	else
  # 	  flash[:alert] = 'Something went wrong - no order created!'
  # 	  render 'new'
  # 	end
  end
  
  def update
    order = Order.find_by_id(params[:id])
    redirect_to orders_path and return false if order.update(order_params)
    # new_or_edit('edit', order)
  end
  
  private
  
  def order_params
    # params.require(:order).permit(:first_course_id, :main_course_id, :drink_id)
  end
end