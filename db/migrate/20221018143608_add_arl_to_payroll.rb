class AddArlToPayroll < ActiveRecord::Migration[7.0]
  def change
    add_column :payrolls, :arl, :decimal, precision: 17, scale: 2, default: '0.0', null: false
  end
end
