class CreateToutiaos < ActiveRecord::Migration[5.1]
  def change
    create_table :toutiaos do |t|
      t.string :uniquekey
      t.datetime :date
      t.string :category
      t.string :author_name
      t.string :url
      t.string :thumbnail_pic_s
      t.string :thumbnail_pic_s02
      t.string :thumbnail_pic_s03

      t.timestamps
    end
  end
end
