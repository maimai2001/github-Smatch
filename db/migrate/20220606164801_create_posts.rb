class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :time
      t.text :about
      t.string :tag
      t.timestamps
    end
  end
end
