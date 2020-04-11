 class CreateEventStats < ActiveRecord::Migration[6.0]
  def change
    create_table :event_stats do |t|
      t.references :event, index: { unique: true }, foreign_key: true
      t.integer :tickets_sold, default: 0
      t.integer :attendance, default: 0
      t.timestamps
    end
  end
end
