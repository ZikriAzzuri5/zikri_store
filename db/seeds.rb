product = Product.find_or_initialize_by(name: 'Harry Potter')
if product.new_record?
  product.price = 65_000
  product.save!
end

product = Product.find_or_initialize_by(name: 'Maze Runner')
if product.new_record?
  product.price = 60_000
  product.save!
end

product = Product.find_or_initialize_by(name: 'Sherlock Holmes')
if product.new_record?
  product.price = 65_000
  product.save!
end


category = Category.find_or_initialize_by(Category: 'Advanture')
if category.new_record?
  category.name = Advanture
  category.save!
end


category = Category.find_or_initialize_by(Category: 'Action')
if category.new_record?
  category.name = Action
  category.save!
end

category = Category.find_or_initialize_by(Category: 'thriller')
if category.new_record?
  category.name = thriller
  category.save!
end

