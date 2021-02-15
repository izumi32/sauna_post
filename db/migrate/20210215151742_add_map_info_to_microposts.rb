class AddMapInfoToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :latitude, :float
    add_column :microposts, :longitude, :float
  end
end
