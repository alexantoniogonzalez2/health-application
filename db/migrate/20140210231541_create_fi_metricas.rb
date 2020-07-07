class CreateFiMetricas < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_metricas do |t|
      t.string :nombre
      t.string :unidad

      t.timestamps
    end
  end
end
