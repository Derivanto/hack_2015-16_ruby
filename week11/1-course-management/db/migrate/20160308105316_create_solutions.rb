class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :body, null: false
      t.references :task, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
