class CreateFiAtencionesSalud < ActiveRecord::Migration
  def change
    create_table :fi_atenciones_salud do |t|
      t.text :motivo_consulta
      t.text :examen_fisico
      t.text :indicaciones_generales
      t.references :agendamiento 	#agendamiento_id
      t.references :persona 	#persona_id
      t.references :tipo_ficha 	#tipo_ficha_id
      t.boolean :es_cronica 
      t.timestamps
    end
  end
end
