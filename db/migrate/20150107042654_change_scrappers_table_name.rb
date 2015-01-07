class ChangeScrappersTableName < ActiveRecord::Migration
  def change
    rename_table :canadian_wh_scrapper, :canadian_wh_scrappers
  end
end
