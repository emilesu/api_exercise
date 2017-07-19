class AddTrainNames < ActiveRecord::Migration[5.1]
  def change
    add_column :trains, :number, :string, :index => true
  end
end
