class CreateMedEnfermedadesNotificacionObligatoria < ActiveRecord::Migration
  def change
    create_table :med_enfermedades_notificacion_obligatoria do |t|
    	t.text :nombre
    	t.references :diagnostico #diagnostico_id
    	t.text :tipo_vigilancia
    	t.text :frecuencia_notificacion
    	t.integer :prioridad
      t.timestamps
    end
  end
end
