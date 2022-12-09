require "Receipt"

RSpec.describe Receipt, "#billing" do
    context "with a exclude good" do
        context " and not imported" do
            it "not add basic sales tax percentage" do
                item = [{ quantity: 2, imported: false, item_name: "book", price: 12.49, categories: ["book"] }]
                receipt = Receipt.new
                expect(receipt.billing(item)).to eq({:items=>["2 book: 24.98"], :sales_taxes=>"0.00", :total=>"24.98"})
            end
        end
        
        context " and imported" do
            it " add basic sales tax percentage" do
                item = [{ quantity: 1, imported: true, item_name: "box of chocolates", price: 10.00, categories: ["food"] }]
                receipt = Receipt.new
                expect(receipt.billing(item)).to eq({:items=>["1 box of chocolates: 10.50"], :sales_taxes=>"0.50", :total=>"10.50"})
            end
        end
    end

    context "with a not exclude good" do
        context " and not imported" do
            it "not add basic sales tax percentage" do
                item = [{ quantity: 1, imported: false, item_name: "music CD", price: 16.49, categories: [] }]
                receipt = Receipt.new
                expect({:items=>["1 music CD: 18.14"], :sales_taxes=>"1.65", :total=>"18.14"})
            end
        end
        
        context " and imported" do
            it " add basic sales tax percentage" do
                item = [{ quantity: 1, imported: true, item_name: "bottle of perfume", price: 54.65, categories: [] }]
                receipt = Receipt.new
                expect({:items=>["1 bottle of perfume: 62.90"], :sales_taxes=>"8.25", :total=>"62.90"})
            end
        end
    end
end