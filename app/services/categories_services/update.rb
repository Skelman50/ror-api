# frozen_string_literal: true

module CategoriesServices
  class Update
    attr_reader :item, :id

    def initialize(item, id)
      @item = item
      @id = id
    end

    def call
      category = Category.find_by(id: id)
      if category
        category.update(item)
        { success: true }
      else
        { message: 'Categoy not found', success: false }
      end
    end
  end
end
