# frozen_string_literal: true

module Category::Operation
  class Update < ApplicationOperation
    step :find_category
    pass :update_category
    step :validation_category

    def find_category(options, id:, **)
      category = Category.find_by(id: id)
      unless category
        options[:error] = { message: 'Category not found', status: 404 }
        return false
      end
      options[:category] = category
    end

    def update_category(_options, params:, category:, **)
      category.update(params)
    end

    def validation_category(options, category:, **)
      result = validation_model(category)
      return true unless result[:error]

      options[:error] = result
      false
    end
  end
end
