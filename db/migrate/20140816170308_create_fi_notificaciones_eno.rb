class CreateFiNotificacionesEno < ActiveRecord::Migration
  def change
    create_table :fi_notificaciones_eno do |t|
    	t.references :persona_diagnostico_atencion_salud #persona_diagnostico_atencion_salud_id
    	t.datetime :fecha_notificacion
    	t.datetime :fecha_primeros_sintomas
    	t.string :confirmacion_diagnostica
    	t.string :antecedentes_vacunacion
    	t.references :pais_contagio #pais_contagio_id
    	t.string :embarazo
    	t.integer :semanas_gestacion
    	t.string :tbc
      t.timestamps
    end
  end
end
