# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name       null: false
      t.string :family_name      null: false
      t.string :first_name_kana  null: false
      t.string :family_name_kana null: false
      t.string :email            null: false
      t.string :password         null: false
      t.string :nick_name        null: false
      t.date :birth_day          null: false
      t.timestamps               null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
