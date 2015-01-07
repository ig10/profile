class AddIpForRequestedUpdate < ActiveRecord::Migration
  def change
    add_column :canadian_wh_scrappers, :ip, :string
  end
end
