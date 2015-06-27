class CreateFiPersonaPrestaciones < ActiveRecord::Migration
  def change
    create_table :fi_persona_prestaciones do |t|    	
      t.references :persona 	#persona_id
      t.references :prestacion 	#prestacion_id
      t.references :atencion_salud	#atencion_salud_id
      t.references :prestador #prestador_id
      t.string :prestador_texto
      t.datetime :fecha_prestacion
      t.boolean :es_antecedente 
      
      t.timestamps
    end
  end
end
