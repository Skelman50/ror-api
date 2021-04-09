# frozen_string_literal: true

class ApplicationOperation < Trailblazer::Operation
  def generate_transaction_error(e)
    if e.message.include?('Validation failed')
      { message: e.message.split(':')[1].strip.split(' ').drop(1).join(' ').split(', ')[0], status: 400 }
    else
      { message: 'Щось пішло не так. Спробуйте пізніше', status: 500 }
    end
  end
end
