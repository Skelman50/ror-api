# frozen_string_literal: true

class CreateFirstUser < ActiveRecord::Migration[6.0]
  def up
    User.create(name: 'Admin', password: 'test')
  end

  def down
    User.delete_all
  end
end
