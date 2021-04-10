# frozen_string_literal: true

module QuestionsPresenters
  class Item
    attr_reader :item, :show_answers

    def initialize(item, show_answers)
      @item = item
      @show_answers = show_answers
    end

    def call
      @item.attributes.merge(merge_attributes)
    end

    private

    def merge_attributes
      category = @item.category
      if !show_answers
        { image: @item.image, category: { title: category.title, id: category.id } }
      else
        { image: @item.image, category: @item.category, answers: @item.answers }
      end
    end
  end
end
