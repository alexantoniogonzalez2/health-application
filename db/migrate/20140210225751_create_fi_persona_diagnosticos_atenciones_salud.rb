class CreateFiPersonaDiagnosticosAtencionesSalud < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_persona_diagnosticos_atenciones_salud do |t|
      t.integer :prioridad
      t.references :persona_diagnostico, index: { name: :persona_diagnostico_index } #persona_diagnostico_id
      t.references :atencion_salud, index: { name: :atencion_salud_index } #atencion_salud_id
      t.references :estado_diagnostico, index: { name: :estado_diagnostico_index } #estado_diagnostico_id
      t.text :comentario
      t.datetime :fecha_inicio
      t.datetime :fecha_termino
      t.boolean :es_cronica
      t.boolean :en_tratamiento  
      t.boolean :primer_diagnostico 
      t.boolean :es_antecedente
      t.boolean :es_ultima_actualizacion
      t.timestamps
    end
  end
end
