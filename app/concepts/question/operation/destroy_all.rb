# frozen_string_literal: true

class QuestionConcept
  class DestroyAll < ApplicationOperation
    step :find_category
    step :find_questions
    step :destroy

    def find_category(options, params:, **)
      options[:category_id] = params[:categoryId]
    end

    def find_questions(options, category_id:, **)
      if category_id.present?
        category = Category.find(category_id)
        options[:questions] = category.questions
      else
        options[:questions] = Question.all
      end
    end

    def destroy(_options, questions:, **)
      QuestionServices::DestroyAll.new(questions).call
    end
  end
end
