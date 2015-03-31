class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string 		:fulltext
      t.belongs_to  :tweet, index: true

      t.timestamps null: false
    end
  end
end
