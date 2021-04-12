# frozen_string_literal: true

module Category::Operation
  class Destroy < ApplicationOperation
    step :find_category
    step :destroy

    def find_category(options, id:, **)
      category = Category.find_by(id: id)
      unless category
        options[:error] = { message: 'Category not found' }
        return false
      end
      options[:category] = category
    end

    def destroy(_options, category:, **)
      CategoryServices::Destroy.new(category).call
    end
  end
end
