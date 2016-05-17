class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.belongs_to :admin_user
      t.belongs_to :ticket
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
