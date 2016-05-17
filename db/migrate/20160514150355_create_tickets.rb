class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.belongs_to :admin_user
      t.belongs_to :status

      t.string :code, null: false
      t.string :subject, null: false
      t.string :email, null: false
      t.string :name, null: false
      t.string :department, null: false
      t.text :description, null: false

      t.timestamps null: false
    end

    add_index :tickets, :code, unique: true
  end
end
