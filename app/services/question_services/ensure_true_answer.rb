# frozen_string_literal: true

module QuestionServices
  class EnsureTrueAnswer
    attr_reader :answers

    def initialize(answers)
      @answers = answers
    end

    def call
      answers = JSON.parse(@answers)
      is_true = answers.find { |a| a['isTrue'] }
      if !is_true
        { error: { message: 'Необхідна хоч одна вірна відповідь', status: 400 } }

      else
        { error: nil, answers: answers }
      end
    end
  end
end
