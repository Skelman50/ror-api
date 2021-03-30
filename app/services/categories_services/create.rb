# frozen_string_literal: true

module CategoriesServices
  class Create
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def call
      category = Category.create(@item)
      if category.valid?
        { success: true }
      else
        { message: category.errors[:title][0], success: false }
      end
    end
  end
end
