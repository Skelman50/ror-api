# frozen_string_literal: true

module QuestionsPresenters
  class Collection
    attr_reader :collection

    def initialize(collection)
      @collection = collection
    end

    def call
      { response: collection.map { |item| Item.new(item, false).call } }
    end
  end
end
