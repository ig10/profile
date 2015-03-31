class AddKompassEditedDate < ActiveRecord::Migration
  def change
    add_column :canadian_wh_scrappers, :kompass_modified_page_date, :date
  end
end
