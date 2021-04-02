# frozen_string_literal: true

module CategoryQuestionsPresenters
  class Item
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def call
      @item.attributes.merge(merge_attributes)
    end

    private

    def merge_attributes
      { image: @item.image, category: @item.category }
    end
  end
end
