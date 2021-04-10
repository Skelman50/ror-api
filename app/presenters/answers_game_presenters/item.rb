# frozen_string_literal: true

module AnswersGamePresenters
  class Item
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def call
      {
        id: item.id,
        title: @item.title,
        description: @item.description,
        displayMessage: @item.displayMessage
      }
    end
  end
end
