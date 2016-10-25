class AlterDescriptionInBusiness < ActiveRecord::Migration
  class Business < ActiveRecord::Base
  end

  def change
    change_column :businesses, :description,  :text
  end
end
