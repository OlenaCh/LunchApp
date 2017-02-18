class OrdersController < ApplicationController
  def new
    unless params[:billed_order].blank?
      render 'thank_you', locals: { billed_order: params[:billed_order] } and return
    end
    render 'new', locals: { ordered_items: find_items(params[:items_ids]) }
  end
  
  def index
    @orders = Order.all
  end
  
  def create
    order = Order.create(order_params)
    order = count_totals(order)
    redirect_to new_order_path(billed_order: order.id) and return false if order.save
  end
  
  def show
    respond_to do |format|
      format.html
      format.pdf { generate_pdf(Order.find_by_id(params[:id])) }
    end
  end
  
  def update
    order = Order.find_by_id(params[:id])
    redirect_to orders_path and return false if order.update(order_update_params)
    new_or_edit('edit', order)
  end
  
  private
  
  def count_totals obj
    total = 0
    obj.order_items.each {|i| total = update_order_item(i, total) }
    obj.update(total: total, status: 'Confirmed')
    obj
  end
  
  def find_items item_ids
    items = []
    item_ids.split(',').each { |id| items << Item.find_by_id(id) }
    items
  end
  
  def generate_pdf order
    pdf = GenerateBill.new(order).run
    send_data pdf.render, filename: "bill_#{order.id}.pdf", type: 'application/pdf'
  end
  
  def order_params
    params.require(:order).permit(:name, :address, :email, :email_msg_required,
                                  order_items_attributes: [:item_id, :amount])
  end
  
  def order_update_params
    params.require(:order).permit(:status)
  end
  
  def update_order_item obj, total
    sum = obj.amount * obj.item.price
    obj.update(total: sum) 
    return total + sum
  end
end