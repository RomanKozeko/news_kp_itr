module CategoriesHelper
  def category_select(category)
    if category.new_record?
      Category.order(:name)
    else
      Category.where("id != #{@category.id}").order(:name)
    end
  end
end
