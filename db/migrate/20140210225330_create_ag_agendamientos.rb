class CreateAgAgendamientos < ActiveRecord::Migration[5.0]
  def change
    create_table :ag_agendamientos do |t|
      t.references :persona             #persona_id
      t.references :quien_pide_hora     #quien_pide_hora_id
      t.datetime :fecha_comienzo        #fecha_comienzo
      t.datetime :fecha_final           #fecha_final
      t.datetime :fecha_llegada_paciente #fecha_final_real
      t.datetime :fecha_comienzo_real   #fecha_comienzo_real
      t.datetime :fecha_final_real      #fecha_final_real      
      t.references :estado              #estado_id
      t.references :especialidad_prestador_profesional  #especialidad_prestador_profesional_id
      t.integer :motivo_consulta
      t.text :comentario_motivo
      t.references :persona_diagnostico_control #persona_diagnostico_control_id
      t.references :capitulo_cie10_control #capitulo_cie10_control_id
      t.references :accion_masiva             #accion_masiva_id
      t.timestamps
    end
  end
end
