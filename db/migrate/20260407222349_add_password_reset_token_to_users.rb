# frozen_string_literal: true

class AddPasswordResetTokenToUsers < ActiveRecord::Migration[8.0]
  def change
    change_table :users do |t|
      t.string :password_reset_token_digest
    end
  end
end
