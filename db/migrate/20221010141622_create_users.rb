class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :full_name, null: false
      t.citext :email, null: false
      t.string :password_digest, null: false
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
