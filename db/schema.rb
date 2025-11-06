ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name, null: false
    t.string :email, null: false
    t.integer :karma, default: 0, null: false
    t.datetime :banned_at
    t.timestamps
  end

  add_index :users, :email, unique: true

  create_table :tasks, force: true do |t|
    t.string :title, null: false
    t.text :description
    t.string :status, default: "pending", null: false
    t.string :priority
    t.date :due_date
    t.datetime :completed_at
    t.references :user, null: false, foreign_key: true
    t.timestamps
  end

  add_index :tasks, :status
  add_index :tasks, :due_date
end
