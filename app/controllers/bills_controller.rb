class BillsController < ApplicationController
  require 'prawn'
  
  def show 
    respond_to do |format|
      format.html
      format.pdf { generate_pdf(Order.find_by_id(params[:billed_order])) }
    end
  end
  
  private
  
  def generate_pdf order
    Prawn::Document.generate('bill.pdf') do
      text ""
    end
  end
end



