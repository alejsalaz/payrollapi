class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :full_name
      t.citext :email
      t.string :password_digest
      t.references :company_id, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
