# frozen_string_literal: true

module QuestionServices
  class DestroyAll
    attr_reader :questions

    def initialize(questions)
      @questions = questions
    end

    def call
      @questions.each do |question|
        Cloudinary::Uploader.destroy("#{ENV['CLOUDINARY_FOLDER']}/#{question.id}")
      end
      @questions.destroy_all
    end
  end
end
