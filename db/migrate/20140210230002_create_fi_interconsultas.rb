class CreateFiInterconsultas < ActiveRecord::Migration
  def change
    create_table :fi_interconsultas do |t|
    	t.references :persona_diagnostico_atencion_salud #persona_diagnostico_atencion_salud_id
    	t.datetime :fecha_solicitud 
    	t.references :prestador_destino #prestador_destino_id
    	t.references :especialidad #especialidad_id
      t.references :persona_conocimiento #persona_conocimiento_id
      t.integer :proposito
      t.text :proposito_otro
      t.text :comentario      
      t.timestamps
    end
  end
end
