# frozen_string_literal: true

module QuestionsGamePresenters
  class Item
    attr_reader :item, :show_answers

    def initialize(item)
      @item = item
    end

    def call
      @item.attributes.merge(merge_attributes)
    end

    private

    def merge_attributes
      image = @item.image
      answers = @item.answers
      { image: { url: image.url },
        answers: AnswersGamePresenters::Collection.new(answers).call }
    end
  end
end
