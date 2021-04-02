# frozen_string_literal: true

class CategoryConcept
  class Destroy < ApplicationOperation
    step :find_category
    step :destroy_category

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

    def destroy_category(_options, category:, **)
      category.destroy
    end
  end
end
