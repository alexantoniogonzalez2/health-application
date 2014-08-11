class CreateFiPersonaDiagnosticosAtencionesSalud < ActiveRecord::Migration
  def change
    create_table :fi_persona_diagnosticos_atenciones_salud do |t|

      t.integer :prioridad
      t.references :persona_diagnostico 	#persona_diagnostico_id
      t.references :atencion_salud	#atencion_salud_id
      t.references :estado_diagnostico 	#estado_diagnostico_id
      t.text :comentario
      t.datetime :fecha_inicio
      t.datetime :fecha_termino
      t.boolean :es_cronica
      t.boolean :en_tratamiento  
      t.boolean :primer_diagnostico  

      t.timestamps
    end
  end
end
