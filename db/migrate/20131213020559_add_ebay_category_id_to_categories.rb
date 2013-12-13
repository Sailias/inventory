class AddEbayCategoryIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :ebay_categoryid, :integer
  end
end
