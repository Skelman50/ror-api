# frozen_string_literal: true

module AnswerServices
  class UpdateAnswers
    attr_reader :answers

    def initialize(answers)
      @answers = answers
    end

    def call
      @answers.each do |answer|
        a = Answer.find(answer['id'])
        raise 'Answer not found!' unless a

        a.update!({ isTrue: answer['isTrue'],
                    displayMessage: answer['displayMessage'],
                    title: answer['title'],
                    description: answer['description'] })
      end
    end
  end
end
