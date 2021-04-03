# frozen_string_literal: true

class Question < ApplicationRecord
  validates :title, length: { minimum: 3, message: 'Недостатньо символів (необхідно мінімум 3)' }

  belongs_to :category
  has_one :image, dependent: :destroy
  has_many :answers, dependent: :destroy
end
