class CreateFiNotificacionesGes < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_notificaciones_ges do |t|
    	t.references :persona_diagnostico_atencion_salud, index: { name: :persona_diagnostico_at_sal_fn } #persona_diagnostico_atencion_salud_id
    	t.references :persona_conocimiento #persona_conocimiento_id
    	t.string :confirmacion_diagnostica
    	t.datetime :fecha_notificacion
      t.timestamps
    end
  end
end
