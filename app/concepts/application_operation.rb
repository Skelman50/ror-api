# frozen_string_literal: true

class ApplicationOperation < Trailblazer::Operation
  def generate_transaction_error(e)
    if e.message.include?('Validation failed')
      { message: e.message.split(':')[1].strip.split(' ').drop(1).join(' ').split(', ')[0], status: 400 }
    else
      { message: 'Щось пішло не так. Спробуйте пізніше', status: 500 }
    end
  end

  def validation_model(item)
    if item.valid?
      { error: nil }
    else
      { message: item.errors[:title][0], status: 400, error: true }
    end
  end

  def encode_token(payload)
    payload[:exp] = Time.now.to_i + Integer(ENV['JWT_EXP'])
    JWT.encode(payload, ENV['JWT_SECRET'])
  end
end
