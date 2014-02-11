class CreateMedMedicamentos < ActiveRecord::Migration
  def change
    create_table :med_medicamentos do |t|
      t.text :nombre
      t.text :descripcion
      t.text :principio_activo
      t.text :codigo

      t.timestamps
    end
  end
end
