# frozen_string_literal: true

module Category::Operation
  class Default < ApplicationOperation
    step :find_default_category

    def find_default_category(options, **)
      category = Category.where(is_active: true).last
      unless category
        options[:error] = { message: 'Category not found', status: 404 }
        return false
      end
      options[:response] = { id: category.id }
    end
  end
end
