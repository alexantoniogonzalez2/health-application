class CreateMedDiagnosticos < ActiveRecord::Migration[5.0]
  def change
    create_table :med_diagnosticos do |t|
      t.string :nombre
      t.string :codigo_cie10
      t.string :descripcion
      t.references :grupo	#grupo_id
      t.integer :numero
      t.boolean :frecuente
      t.boolean :nodo_terminal
      t.string :genero
      t.timestamps
    end
  end
end
