# frozen_string_literal: true

class QuestionConcept
  class GetAll < ApplicationOperation
    step :find_questions
    step :find_questions_count
    step :prepare_json

    def find_questions(options, params:, **)
      questions = Question.order(created_at: :desc).all.limit(params[:limit]).offset(params[:offset])
      items = QuestionsPresenters::Collection.new(questions).call
      options[:items] = items[:response]
      options[:questions] = questions
    end

    def find_questions_count(options, **)
      options[:count] = Question.count
    end

    def prepare_json(options, items:, count:, **)
      options[:response] = {
        items: items,
        count: count
      }
    end
  end
end
