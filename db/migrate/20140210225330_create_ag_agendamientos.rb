class CreateAgAgendamientos < ActiveRecord::Migration
  def change
    create_table :ag_agendamientos do |t|
      t.datetime :fecha_comienzo        #fecha_comienzo
      t.datetime :fecha_final           #fecha_final
      t.datetime :fecha_comienzo_real   #fecha_comienzo_real
      t.datetime :fecha_final_real      #fecha_final_real
      t.references :persona             #persona_id
      t.references :administrativo      #administrativo_id
      t.references :agendamiento_estado #agendamiento_estado_id
      t.references :especialidad_prestador_profesional  #especialidad_prestador_profesional_id

      t.timestamps
    end
  end
end
