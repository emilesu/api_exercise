class AddTitleToToutiaos < ActiveRecord::Migration[5.1]
  def change
    add_column :toutiaos, :title, :string
  end
end
