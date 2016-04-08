class CreateLinks < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.string :title
      t.string :link
      t.string :comment
    end
  end
  
  def down
    drop_table :videos
  end
end
