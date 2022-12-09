class Receipt

    def billing(data)
        basic_sales_tax_percentage = 0.1 #except books, food and medical
        import_duty_percentage = 0.05 #all goods
        result = []
        items_detail = []
        sales_taxes = 0
        total = 0
    
        data.each do |item|
            basic_sales_tax = 0
            import_duty = 0
            price = (item[:price].to_f * item[:quantity].to_f)
            
            basic_sales_tax = ((price * basic_sales_tax_percentage) * 20).ceil / 20.0  if (item[:categories].nil? or !item[:categories].any? { |a| ['book', 'food', 'medical'].include?(a) })
            import_duty = ((price * import_duty_percentage) * 20).ceil / 20.0 if item[:imported]
            sub_total = (basic_sales_tax + import_duty + price) 
            
            items_detail << "#{item[:quantity]} #{item[:item_name]}: #{'%.2f' % sub_total}"
            
            sales_taxes += ((basic_sales_tax.to_f + import_duty.to_f) * 20).ceil / 20.0
            total += sub_total
        end
    
        return { items: items_detail, sales_taxes: "#{'%.2f' % sales_taxes}", total: "#{'%.2f' % total}" }
    
    end
end