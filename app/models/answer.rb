# frozen_string_literal: true

class Answer < ApplicationRecord
  validates :title, length: { minimum: 3, message: 'Недостатньо символів (необхідно мінімум 3)' }
  validates :description, length: { minimum: 3, message: 'Недостатньо символів (необхідно мінімум 3)' }
  validates :displayMessage, length: { minimum: 3, message: 'Недостатньо символів (необхідно мінімум 3)' }

  belongs_to :question
end
