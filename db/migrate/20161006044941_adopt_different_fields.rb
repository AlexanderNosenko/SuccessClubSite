class AdoptDifferentFields < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end
  class Landing < ActiveRecord::Base
  end

  def change
  	add_column :users, :refback_percent, :integer, default: 0
  	change_column :users, :ancestry, :text
  	add_column :landings, :business_id, :integer
  end
end
