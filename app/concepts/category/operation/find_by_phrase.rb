# frozen_string_literal: true

class CategoryConcept
  class FindByPhrase < ApplicationOperation
    step :get_phrase
    step :find_in_category
    step :find_in_questions
    step :get_categories

    def get_phrase(options, params:, **)
      options[:phrase] = params[:phrase]
    end

    def find_in_category(options, phrase:, **)
      options[:in_categories] = Category.where('title ILIKE ?', "%#{phrase}%")
    end

    def find_in_questions(options, phrase:, **)
      categories = Category.all
      categories_questions = categories.map do |c|
        c.questions.where('questions.title ILIKE ?', "%#{phrase}%")
      end
      result = categories_questions.flatten.map(&:category)

      options[:in_questions] = result.uniq
    end

    def get_categories(options, in_categories:, in_questions:, **)
      response = in_categories + in_questions
      options[:response] = CategoryPresenters::Collection.new(response.uniq).call
    end
  end
end
