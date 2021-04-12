# frozen_string_literal: true

module AnswerServices
  class CreateAnswers
    attr_reader :answers, :question

    def initialize(answers, question)
      @answers = answers
      @question = question
    end

    def call
      @answers.each do |answer|
        Answer.create!({ isTrue: answer['isTrue'],
                         displayMessage: answer['displayMessage'],
                         title: answer['title'],
                         description: answer['description'],
                         question_id: @question.id })
      end
    end
  end
end