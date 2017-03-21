class OrdersController < ApplicationController
  before_action :authenticate_admin!, except: [:new, :create, :show]
  before_action :check_for_admin, only: [:new, :create, :show]
  
  def index
    @orders = Order.all
  end
  
  def new
    thank_you_page and return false unless params[:billed_order].blank?
    render 'new', locals: { ordered_items: ordered_items_list }
  end
  
  def create
    order = Order.create(order_params)
    order = count_totals(order)
    redirect_to new_order_path(billed_order: order.id) and return if order.save
    redirect_to session.delete(:return_to)
  end
  
  def show
    respond_to_format(:pdf, :generate_pdf)
  end
  
  def update
    order = Order.find_by_id(params[:id])
    respond_to_format(:json, :json_success) if order.update(order_update_params)
  end
  
  private
  
  def check_for_admin
    redirect_to users_only_path if current_admin
  end
  
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
  
  def generate_pdf 
    order = Order.find_by_id(params[:id])
    pdf = GenerateBill.new(order).run
    send_data pdf.render, filename: "bill_#{order.id}.pdf", type: 'application/pdf'
  end
  
  def json_success
    render json: { status: 200 }
  end
  
  def order_params
    params.require(:order).permit(:name, 
                                  :address, 
                                  :email, 
                                  order_items_attributes: [:item_id, :amount])
  end
  
  def order_update_params
    params.require(:order).permit(:status)
  end
  
  def ordered_items_list
    return find_items(params[:items_ids]) unless params[:items_ids].blank?
    nil
  end
  
  def respond_to_format frmt, actn
    respond_to do |format| 
      format.html 
      format.send(frmt) { self.send(actn) }
    end
  end
  
  def thank_you_page
    render 'thank_you', locals: { billed_order: params[:billed_order] }
  end
  
  def update_order_item obj, total
    sum = obj.amount * obj.item.price
    obj.update(total: sum) 
    return total + sum
  end
end