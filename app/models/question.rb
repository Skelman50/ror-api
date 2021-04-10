# frozen_string_literal: true

class Question < ApplicationRecord
  validates :title, length: { minimum: 3, message: 'Недостатньо символів (необхідно мінімум 3)' }
  validates :category_id, presence: { message: 'Необхідно указати категорію' }

  belongs_to :category
  has_one :image, -> { select(:id, :url, :question_id) }, dependent: :destroy
  # has_one :only_image_url, -> { select(:id, :url, :question_id) }, class_name: 'Image'
  has_many :answers, dependent: :destroy
  has_many :answers_for_game, -> { select(:id, :title, :question_id) }, class_name: 'Answer'
end
