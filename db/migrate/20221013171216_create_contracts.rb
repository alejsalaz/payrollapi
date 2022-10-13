class CreateContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :contracts, id: :uuid do |t|
      t.references :employee, null: false, foreign_key: true, type: :uuid
      t.string :job_title, null: false
      t.decimal :base_salary, null: false
      t.date :start_date, null: false
      t.date :termination_date, null: false

      t.timestamps
    end
  end
end
