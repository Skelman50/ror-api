# frozen_string_literal: true

class Question
  class CreateQuestionPolicy
    def self.call(options, **)
      answers = JSON.parse(options[:answers])
      is_true = answers.find { |a| a[:isTrue] }
      unless is_true
        options[:error] = 'Необхідна хоч одна вірна відпоідь'
        false
      end
    end
  end
end
