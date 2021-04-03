# frozen_string_literal: true

class QuestionConcept
  class Create < ApplicationOperation
    step :start_transition

    def start_transition(options, params:, **)
      ActiveRecord::Base.transaction do
        question = create_question(params)
        create_answers(params, question)
        create_image(question, params)
      end
    rescue StandardError => e
      options[:error] = generate_error(e)
      false
    end

    private

    def create_question(params)
      Question.create!(title: params[:title], category_id: params[:category_id])
    end

    def create_answers(params, question)
      answers = JSON.parse(params[:answers])
      answers.each do |answer|
        Answer.create!(isTrue: answer[:isTrue], displayMessage: answer[:displayMessage], title: answer[:title], description: answer[:description], question_id: question.id)
      end
    end

    def create_image(question, params)
      Image.create!(question_id: question.id, image: params[:image])
    end

    def generate_error(e)
      { message: e.message.split(': ')[1].split(' ').drop(1).join(' '), status: 400 }
    end
  end
end
