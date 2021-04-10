# frozen_string_literal: true

module Category::Operation
  class Default < ApplicationOperation
    step :find_default_category

    def find_default_category(options, **)
      category = Category.where(is_active: true).last
      if category
        options[:response] = { id: category.id }
      else
        options[:error] = { message: 'Category not found', status: 404 }
        false
      end
    end
  end
end
