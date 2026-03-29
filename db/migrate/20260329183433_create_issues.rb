class CreateIssues < ActiveRecord::Migration[8.1]
  def change
    create_table :issues do |t|
      t.references :column, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :priority
      t.datetime :due_date
      t.integer :assignee_id

      t.timestamps
    end
  end
end
