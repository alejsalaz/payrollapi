class AddArlToEmployee < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE employee_risk_class AS ENUM ('i', 'ii', 'iii', 'iv', 'v');
    SQL
    # TODO: El riesgo va en otro lado
    add_column :employees, :risk_class, :employee_risk_class, null: false
  end

  def down
    remove_column :employees, :risk_class
    execute <<-SQL
      DROP TYPE employee_risk_class;
    SQL
  end
end
