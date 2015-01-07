class AddExtraFieldsForXmlContent < ActiveRecord::Migration
  def change
    add_column :canadian_wh_scrapper, :xml_content, :text, after: :page_content
  end
end
