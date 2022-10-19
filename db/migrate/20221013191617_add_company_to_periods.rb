class AddCompanyToPeriods < ActiveRecord::Migration[7.0]
  def change
    add_reference :periods, :company, null: false, foreign_key: true, type: :uuid
  end
end
