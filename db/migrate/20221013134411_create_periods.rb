class CreatePeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :periods, id: :uuid do |t|
      t.date :start_date, null: false, default: Date.new(Date.today.year, Date.today.month)
      t.date :end_date, null: false, default: Date.new(Date.today.year, Date.today.month).end_of_month

      t.timestamps
    end
  end
end
