# frozen_string_literal: true

module Question::Operation
  class GetAll < ApplicationOperation
    step :find_questions
    step :find_questions_count
    step :prepare_json

    def find_questions(options, params:, **)
      questions = Question.includes(:image, :category)
                          .order(created_at: :desc)
                          .limit(params[:limit])
                          .offset(params[:offset])
      options[:items] = QuestionsPresenters::Collection.new(questions).call
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
