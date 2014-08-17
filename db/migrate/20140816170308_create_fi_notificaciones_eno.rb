class CreateFiNotificacionesEno < ActiveRecord::Migration
  def change
    create_table :fi_notificaciones_eno do |t|
    	t.references :persona_diagnostico_atencion_salud #persona_diagnostico_atencion_salud_id
    	t.datetime :fecha_notificacion
    	t.datetime :fecha_primeros_sintomas
    	t.text :confirmacion_diagnostica
    	t.text :antecedentes_vacunacion
    	t.references :pais_contagio #pais_contagio_id
    	t.text :embarazo
    	t.integer :semanas_gestacion
    	t.text :tbc
      t.timestamps
    end
  end
end
