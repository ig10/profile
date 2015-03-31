class AddKompassScrapperFields < ActiveRecord::Migration
  def change
    add_column :canadian_wh_scrappers, :kompass_year, :string
  end
end
