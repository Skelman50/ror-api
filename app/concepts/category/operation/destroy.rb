# frozen_string_literal: true

class Category
  module Operation
    class Destroy < ApplicationOperation
      step :find_category
      step :destroy

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

      def destroy(_options, category:, **)
        CategoryServices::Destroy.new(category).call
      end
    end
  end
end
