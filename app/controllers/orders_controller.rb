class OrdersController < ApplicationController
  def new
  end
  
  def index
    @orders = Order.all
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
    redirect_to orders_path and return false if order.update(order_update_params)
    new_or_edit('edit', order)
  end
  
  private
  
  def order_update_params
    params.require(:order).permit(:status)
  end
end