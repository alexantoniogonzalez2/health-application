class CreateFiPersonaDiagnosticos < ActiveRecord::Migration
  def change
    create_table :fi_persona_diagnosticos do |t|
      t.datetime :fecha_inicio
      t.datetime :fecha_termino
      t.references :persona 	#persona_id
      t.references :diagnostico 	#diagnostico_id
      t.references :estado_diagnostico 	#estado_diagnostico_id
      t.references :gesta 	#gesta_id
      t.boolean :es_cronica 
      t.timestamps
    end
  end
end
