# frozen_string_literal: true

module CategoryPresenters
  class Item
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def call
      @item.attributes.merge(questions_count)
    end

    private

    def questions_count
      { questions_count: @item.questions.count }
    end
  end
end
