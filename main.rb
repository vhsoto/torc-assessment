require "./lib/Receipt.rb"

def assign_categories(name)
    book = ['books', 'book'] # add whatever word that you want to categorize like a book
    food = ['chocolate', 'chocolates', 'pizza', 'rice'] # add whatever word that you want to categorize like a food
    medical = ['pill', 'pills']
    categories = []

    categories << 'book' if book.any? { |a| name.split.include?(a) }
    categories << 'food' if food.any? { |a| name.split.include?(a) }
    categories << 'medical' if medical.any? { |a| name.split.include?(a) }
    categories
end

def get_data(item_list)
    result = []
    item_list.each do |item|
        item = item.split(' ')
        item.delete('at')
        quantity = item.first
        price = item.last
        imported = item[1] == 'imported' ? true : false
        item.shift
        item.pop
        item_name  = item.join(' ')
        categories = assign_categories(item_name)
        result << { quantity: quantity, imported: imported, item_name: item_name, price: price, categories: categories }
    end
    return result
end

def show_results(results)
    results.each do |key, value|
        value.each { |a| puts a } if key.to_s == 'items'
        puts "Sales Taxes: #{value}" if key.to_s =='sales_taxes'
        puts "Total: #{value}" if key.to_s == 'total'
    end
end

# Import data

file_paths = Dir["input/**/*.txt"]

file_paths.each do |path|
    item_list = File.readlines(path).map(&:chomp)

    # extract data
    data = get_data(item_list)


    # Calculates
    results = Receipt.new.billing(data)


    # Show results
    puts '-----------------------------'
    puts "Ouput: #{path.split('/')[1]}"
    puts '-----------------------------'
    show_results(results)
    puts
end