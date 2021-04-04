# frozen_string_literal: true

module CloudinaryServices
  class DeleteAll
    attr_reader :questions

    def initialize(questions)
      @questions = questions
    end

    def call
      @questions.each do |question|
        Cloudinary::Uploader.destroy("#{ENV['CLOUDINARY_FOLDER']}/#{question.id}")
      end
    end
  end
end
