class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies, id: :uuid do |t|
      t.string :nit, null: false
      t.string :legal_name, null: false
      t.string :display_name

      t.timestamps
    end
  end
end
