# frozen_string_literal: true

class ApplicationOperation < Trailblazer::Operation
  # protected

  # def not_authorized_handler(options, **)
  #   options[:validation_errors] = { error: 'Not authorized' }
  # end

  # def error_handler(options, **)
  #   message = options[:errors] || 'Not authorized'

  #   options[:validation_errors] = { error: message }
  # end
end
