# frozen_string_literal: true

class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :original
      t.string :short
      t.string :sanitized
      t.timestamps
    end
    add_index :urls, :short
    add_index :urls, :sanitized
  end
end
