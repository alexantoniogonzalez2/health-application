class CreateAgAccionMasiva < ActiveRecord::Migration[5.0]
  def change
    create_table :ag_accion_masiva do |t|
    	t.string :estado
    	t.references :responsable #responsable_id
      t.references :especialidad_prestador_profesional #especialidad_prestador_profesional_id
    	t.integer :total_agendamientos
    	t.integer :agendamientos_eliminados
    	t.integer :agendamientos_sin_eliminar
      t.timestamps null: false
    end
  end
end
