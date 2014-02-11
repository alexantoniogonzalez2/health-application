class CreateFiMetricas < ActiveRecord::Migration
  def change
    create_table :fi_metricas do |t|
      t.text :nombre
      t.text :unidad

      t.timestamps
    end
  end
end
