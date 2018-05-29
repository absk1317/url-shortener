# frozen_string_literal: true

class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :short_url
      t.timestamps
    end
    add_index :urls, :short_url, unique: true
  end
end