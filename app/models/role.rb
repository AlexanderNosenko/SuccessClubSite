class Role < ActiveRecord::Base
  has_many :users

  def self.info_select()
    self.select(:id, :name, :description, :partnership_depth)
  end

end
