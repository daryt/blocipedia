class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.integer :user_id
      t.boolean :is_private

      t.timestamps
    end
  end
end
