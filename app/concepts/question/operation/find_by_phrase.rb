# frozen_string_literal: true

module Question::Operation
  class FindByPhrase < ApplicationOperation
    pass :get_cagory_id
    pass :get_questions

    def get_cagory_id(options, params:, **)
      options[:category_id] = if params[:id].present?
                                params[:id]
                              else
                                false
                              end

      def get_questions(options, category_id:, **)
        options[:questions] = if category_id
                                Question.where(category_id: category_id)
                              else
                                Question.all
                              end
      end
    end
  end
end
