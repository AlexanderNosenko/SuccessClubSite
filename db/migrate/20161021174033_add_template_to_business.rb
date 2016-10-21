class AddTemplateToBusiness < ActiveRecord::Migration
  class Business < ActiveRecord::Base
  end

  def change
  	add_column :businesses, :link_template, :string, default: 'https://'
  end
end
