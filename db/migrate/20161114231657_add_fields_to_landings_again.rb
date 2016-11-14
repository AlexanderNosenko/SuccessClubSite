class AddFieldsToLandingsAgain < ActiveRecord::Migration
  class Landings < ActiveRecord::Base
  end

  def change
    add_column :landings, :preview, :string
  end
end
