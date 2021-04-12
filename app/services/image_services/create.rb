# frozen_string_literal: true

module ImageServices
  class Create
    attr_reader :question, :params

    def initialize(question, params)
      @question = question
      @params = params
   
    end

    def call
      image = CloudinaryServices::Upload.new(@params, @question).call
      file = File.open(@params[:image].tempfile.path)
      file_data = file.read
      Image.create!(question_id: @question.id, image: file_data, url: image['url'])
    end
  end
end