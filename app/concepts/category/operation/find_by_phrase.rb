# frozen_string_literal: true

class Category
  class FindByPhrase < ApplicationOperation
    step :get_phrase
    step :find_in_category
    step :find_in_questions
    step :find_in_answers
    step :get_categories

    def get_phrase(options, params:, **)
      options[:phrase] = params[:phrase]
    end

    def find_in_category(options, phrase:, **)
      options[:in_categories] = Category.where('title ILIKE ?', "%#{phrase}%")
    end

    def find_in_questions(options, phrase:, **)
      questions = Question.where('title ILIKE ?', "%#{phrase}%")
      options[:in_questions] = questions.map(&:category).uniq
    end

    def find_in_answers(options, phrase:, **)
      answers = Answer.where(find_in_answers_query, "%#{phrase}%", "%#{phrase}%", "%#{phrase}%")
      questions = answers.map(&:question).uniq
      options[:in_answers] = questions.map(&:category).uniq
    end

    def get_categories(options, in_categories:, in_questions:, in_answers:, **)
      response = in_categories + in_questions + in_answers
      options[:response] = CategoryPresenters::Collection.new(response.uniq).call
    end

    private

    def find_in_answers_query
      'title ILIKE ? OR "displayMessage" ILIKE ? OR description ILIKE ?'
    end
  end
end
