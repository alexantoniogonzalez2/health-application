class CreateMedMedicamentos < ActiveRecord::Migration
  def change
    create_table :med_medicamentos do |t|
      t.string :nombre
      t.string :descripcion
      t.string :codigo_isp
      t.integer :cantidad
      t.references :medicamento_tipo #medicamento_tipo_id
      t.references :laboratorio #laboratorio_id      
      t.timestamps
    end
  end
end
