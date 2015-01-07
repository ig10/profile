class CreateTableForWhScrapper < ActiveRecord::Migration
  def change
    create_table :canadian_wh_scrapper do |t|
      t.string :category
      t.string :country
      t.text :page_content
      t.integer :quota
      t.integer :remaining
      t.string :status
      t.date :modified_page_date
      t.timestamps
    end
  end
end
