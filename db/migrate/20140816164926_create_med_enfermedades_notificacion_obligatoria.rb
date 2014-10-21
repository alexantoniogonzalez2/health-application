class CreateMedEnfermedadesNotificacionObligatoria < ActiveRecord::Migration
  def change
    create_table :med_enfermedades_notificacion_obligatoria do |t|
    	t.string :nombre
    	t.references :diagnostico #diagnostico_id
    	t.string :tipo_vigilancia
    	t.string :frecuencia_notificacion
    	t.integer :prioridad
      t.timestamps
    end
  end
end
