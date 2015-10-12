class CreateFiPersonaMedicamentos < ActiveRecord::Migration
  def change
    create_table :fi_persona_medicamentos do |t|
      t.datetime :fecha_inicio
      t.datetime :fecha_final
      t.references :persona 	#persona_id
      t.references :medicamento 	#medicamento_id
      t.references :persona_diagnostico 	#persona_diagnostico_id
      t.references :atencion_salud 	#atencion_salud_id
      t.integer :cantidad
      t.integer :periodicidad
      t.integer :duracion
      t.integer :total
      t.references :persona_vacuna #persona_vacuna_id
      t.boolean :es_antecedente 
      t.text :indicacion      
      t.timestamps
    end
  end
end
