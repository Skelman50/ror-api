# frozen_string_literal: true

module CategoriesServices
  class DestroyById
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def call
      category = Category.find_by(id: item[:id])
      if category
        category.destroy
        { success: true }
      else
        { message: 'Category not found', success: false }
      end
    end
  end
end
