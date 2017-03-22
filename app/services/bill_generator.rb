class BillGenerator
  def initialize order
    @order = order
    @pdf = Prawn::Document.new(margin: [40, 50, 40, 50], 
                               font: 'Times-Roman', font_size: 14)
  end
  
  def run
    methods = [:add_header, :add_order_details, :add_user, :add_items]
    methods.each { |method| self.send(method); @pdf.move_down 15 }
    stamp_bill_with(@order.status)
    return @pdf
  end
  
  private
  
  def add_header
    @pdf.font('Courier', size: 18, style: :bold_italic) do
      @pdf.pad(10) { @pdf.text('LunchApp! Always tasty!', color: '89c86a') }
    end
  end
  
  def add_items
    items = items_rows
    create_table items
  end
  
  def add_order_details
    @pdf.text("Order # #{@order.id}", details_options) 
    @pdf.text("Order created at #{@order.created_at}", details_options)
  end
  
  def add_user
    @pdf.text("Full name: #{@order.name}", color: '89c86a')
    @pdf.text("Address: #{@order.address}", color: '89c86a')
  end
  
  def items_rows
    items = [['Title', 'Amount', 'Price to pay']]
    @order.order_items.each do |i|
      items += [["#{i.item.title}", "#{i.amount}", "#{i.total}"]]
    end
    items += [[{content: 'Total', colspan: 2}, "#{@order.total}"]]
  end
  
  def create_table items
    size = items.length
    @pdf.table items, { header: true, width: 500 } do |table|
      table_header_style table.row(0)
      table.row(1..size - 1).each { |row| table_row_style row }
    end
  end
  
  def details_options
    { style: :italic, color: '89c86a' }
  end
  
  def set_stamp_style txt
    @pdf.rotate(25, origin: [-5, -5]) do
      stamp_ellipse_style 
      stamp_text_style 'Confirmed'
    end
  end
  
  def stamp_bill_with status
    @pdf.create_stamp(status) { set_stamp_style status }
    @pdf.stamp_at status, [120, 400]
  end
  
  def stamp_ellipse_style
    @pdf.stroke_color '89c86a'
    @pdf.stroke_ellipse [0, 0], 40, 21
    @pdf.stroke_color 'fff2e6'
  end
  
  def stamp_text_style txt
    @pdf.fill_color '89c86a'
    @pdf.font('Courier') { @pdf.draw_text txt, at: [-31, -3] }
    @pdf.fill_color 'fff2e6'
  end
  
  def table_header_style header
    header.font_style = :bold_italic
    header.background_color = '89c86a'
    header.border_color = '89c86a'
    header.text_color = 'fff2e6'
  end
  
  def table_row_style row
    row.background_color = 'fff2e6'
    row.border_color = '89c86a'
    row.style({ text_color: '89c86a' })
  end
end