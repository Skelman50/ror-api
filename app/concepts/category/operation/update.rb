# frozen_string_literal: true

module Category::Operation
  class Update < ApplicationOperation
    step :find_category
    step :update_category

    def find_category(options, id:, **)
      category = Category.find_by(id: id)
      if category
        options[:category] = category
        true
      else
        options[:error] = { message: 'Category not found' }
        false
      end
    end

    def update_category(options, category:, params:, **)
      category.update(params)
      if category.valid?
        true
      else
        options[:error] = { message: category.errors[:title][0] }
        false
      end
    end
  end
end
