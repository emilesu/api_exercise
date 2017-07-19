class ChangeTrainNames < ActiveRecord::Migration[5.1]
  def change
    remove_column :trains, :namber
  end
end
