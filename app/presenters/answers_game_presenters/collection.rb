# frozen_string_literal: true

module AnswersGamePresenters
  class Collection
    attr_reader :collection

    def initialize(collection)
      @collection = collection
    end

    def call
      collection.map { |item| Item.new(item).call }
    end
  end
end
     