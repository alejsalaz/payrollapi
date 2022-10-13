class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees, id: :uuid do |t|
      t.string :card_id, null: false
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.string :full_name, null: false
      # t.references :contract, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
