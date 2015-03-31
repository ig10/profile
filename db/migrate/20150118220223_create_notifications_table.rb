class CreateNotificationsTable < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :source
      t.string :message
      t.string :ip
      t.timestamps
    end
  end
end
